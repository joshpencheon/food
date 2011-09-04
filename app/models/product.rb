class Product < ActiveRecord::Base
  attr_accessible :name, :ean
  
  validates_presence_of :name
  validates_uniqueness_of :name
  
  before_validation :format_ean
  validates_length_of :ean, :is => 13, :allow_blank => true

  
  has_many :purchases, :dependent => :destroy
  has_many :baskets, :through => :purchases, :uniq => true
  
  def self.find_for_autocomplete(query)
    where('ean like ? or name like ?', "#{query}%", "%#{query}%")
  end
  
  def self.find_or_create_from_params(params)
    existing = find_by_name(params[:name])
    if existing
      existing
    else
      create!(:name => params[:name], :ean => params[:ean])
    end
  end
  
  def purchase_count
    purchases.map(&:quantity).sum
  end
  
  def total_spending
    purchases.map(&:cost).sum
  end
  
  private
  
  def format_ean
    self.ean = ean.blank? ? nil : ean.to_s.gsub(/[^\d]/, '')
  end
end
