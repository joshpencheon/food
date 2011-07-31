class Purchase < ActiveRecord::Base
  belongs_to :product
  belongs_to :basket
  
  default_scope :order => 'created_at desc'
  
  validates_presence_of :quantity
  validates_presence_of :unit_price_in_pence
  
  validates_numericality_of :quantity
  validates_numericality_of :unit_price_in_pence
  validates_numericality_of :saving_in_pence
    
  def save(*args)
    return self.destroy if quantity < 1
    
    other_purchases = basket.purchases - [ self ]
    
    if other = other_purchases.detect { |p| p.product_id == product_id && p.unit_price_in_pence == unit_price_in_pence }    
      other.quantity += quantity
      other.saving   += saving
      other.save
    else
      super
    end
  end
  
  def cost
    unit_price * quantity - (saving || 0)
  end
  
  def unit_price
    unit_price_in_pence ? (unit_price_in_pence.to_f / 100).round(2) : nil
  end
  
  def unit_price=(price_in_pounds)
    write_attribute(:unit_price_in_pence, (price_in_pounds.to_f.round(2) * 100).round(0).to_i)
  end
  
  def saving
    saving_in_pence ? (saving_in_pence.to_f / 100).round(2) : nil
  end
  
  def saving=(saving_in_pounds)
    write_attribute(:saving_in_pence, (saving_in_pounds.to_f.round(2) * 100).round(0).to_i)
  end
end
