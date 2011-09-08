class Basket < ActiveRecord::Base

  belongs_to :shop
  
  has_many :purchases, :extend => MergePurchasesExtension
  has_many :products, :through => :purchases, :uniq => true
  has_many :bills, :autosave => true
  
  before_validation :set_shop_date
  before_validation :ensure_billed
  
  validates_presence_of :shop
  validates_presence_of :shop_date
    
  after_create :create_primary_bill
  
  def shop_date_string
    shop_date.nil? ? '' : shop_date.strftime('%A, %d %B %y')
  end
    
  def cost
    purchases.map(&:cost).sum
  end
  
  private
  
  def set_shop_date
    self.shop_date ||= Date.today.to_time
  end
  
  def create_primary_bill
    bills.create!(:proportion => 100)
  end
  
  def ensure_billed
    if bills.map(&:proportion).sum != 100
      bills.each { |bill| bill.proportion = (100.to_f / bills.length).ceil } 
    end
  end
  
end
