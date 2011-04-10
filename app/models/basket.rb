class Basket < ActiveRecord::Base
  has_many :purchases
  has_many :products, :through => :purchases
  belongs_to :shop
  
  def validate
    errors.add(:shop_date, 'is not valid') if @shop_date_invalid
  end
  
  def shop_date_string
    shop_date.nil? ? '' : shop_date.strftime('%A, %d %B %y')
  end
  
  def shop_date_string=(date)
    self.shop_date = Time.parse(date)
  rescue ArgumentError
    @shop_date_invalid = true
  end
  
  def cost
    purchases.map(&:cost).sum
  end
end
