class Saving < ActiveRecord::Base
  SAVING_TYPES = [
    'buy_one_get_one_free'
  ]
  
  belongs_to :purchase
  
  before_save :set_amount
  
  def amount
    amount_in_pence ? (amount_in_pence.to_f / 100).round(2) : nil
  end
  
  def amount=(amount_in_pounds)
    write_attribute(:amount_in_pence, (amount_in_pounds.to_f.round(2) * 100).round(0).to_i)
  end
  
  private
  
  def set_amount
    if SAVING_TYPES.include?(saving_type)
      self.amount = self.send(saving_type.to_sym) 
    end
  end
  
  def buy_one_get_one_free
    Rails.logger.info("************* #{purchase_id}")
    purchase.quantity.div(2) * purchase.unit_price
  end
end