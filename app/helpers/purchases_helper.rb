module PurchasesHelper

  def div_for_purchase(purchase, options = {}, &block)
    status = purchase.creation_status
    (options[:class] ||= '') << status.to_s if status
    
    div_for(purchase, options, &block)
  end
  
end
