class Purchase < ActiveRecord::Base
  belongs_to :product
  belongs_to :basket
  
  default_scope :order => 'created_at desc'
  
  validates_presence_of :quantity
  validates_presence_of :unit_price
  
  validates_numericality_of :quantity
  validates_numericality_of :unit_price
  validates_numericality_of :saving
    
def save_with_other_product_check
    other_purchases = Basket.find(basket_id).purchases - [ self ]
    
    if other = other_purchases.detect { |p| p.product_id == product_id && p.unit_price == unit_price }
      
      Rails.logger.info('@@@')
      Rails.logger.info(other.inspect)
      
      other.quantity += quantity
      other.saving   += saving
      other.save_without_other_product_check
    else
      save_without_other_product_check
    end
  end
  alias_method_chain :save, :other_product_check  
  
  def save_with_zero_quantity_check
    if quantity < 1
      self.destroy
    else
      save_without_zero_quantity_check
    end
  end
  alias_method_chain :save, :zero_quantity_check
  
  def cost
    unit_price * quantity - (saving || 0)
  end
end
