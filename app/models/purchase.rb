class Purchase < ActiveRecord::Base
  belongs_to :product
  belongs_to :basket
  
  default_scope :order => 'created_at desc'

  def save_with_other_product_check
    other_purchases = Basket.find(basket_id).purchases - [ self ]
    
    if other = other_purchases.detect { |p| p.product_id == product_id && p.unit_price == unit_price }
      other.quantity += quantity
      other.save_without_other_product_check
    else
      save_without_other_product_check
    end
  end
  alias_method_chain :save, :other_product_check  

  def cost
    unit_price * quantity - (saving || 0)
  end
end
