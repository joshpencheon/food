module BasketsHelper

  def tagged_purchases_for(basket)
    purchases = basket.purchases.order('updated_at desc').reject(&:new_record?)
    
    log = basket.purchases.update_log
    
    purchases.each do |purchase|
      status = log[purchase.id]
      purchase.creation_status = status if status
    end
    
    purchases
  end

end
