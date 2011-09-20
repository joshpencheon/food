class Purchase < ActiveRecord::Base
  belongs_to :product
  belongs_to :basket
    
  validates_presence_of :quantity
  validates_presence_of :unit_price_in_pence
  validates_presence_of :product_id
  validates_presence_of :basket_id
  
  validates_numericality_of :quantity
  validates_numericality_of :unit_price_in_pence
  
  # Track whether this purchase was :created 
  # or :updated or neither (nil).  
  attr_accessor :creation_status
  
  after_save :delete_if_zero_quantity
    
  def merge_with(purchase)
    self.quantity += purchase.quantity
    self
  end
    
  def cost
    unit_price * quantity rescue 0
  end
  
  def unit_price
    unit_price_in_pence ? (unit_price_in_pence.to_f / 100).round(2) : nil
  end
  
  def unit_price=(price_in_pounds)
    write_attribute(:unit_price_in_pence, (price_in_pounds.to_f.round(2) * 100).round(0).to_i)
  end
  
  private
  
  def delete_if_zero_quantity
    delete if quantity.zero?
  end
end
