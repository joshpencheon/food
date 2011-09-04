class Basket < ActiveRecord::Base
  
  has_many :purchases
  has_many :products, :through => :purchases, :uniq => true
  belongs_to :shop
  
  validates_presence_of :shop
  validates_presence_of :shop_date
  
  before_validation :set_shop_date
  
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
end
