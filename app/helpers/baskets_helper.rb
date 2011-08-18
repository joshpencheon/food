module BasketsHelper

  def tagged_purchases_for(basket)
    purchases = basket.purchases.reject(&:new_record?)
    
    if @purchase_created
      last_created = purchases.sort_by(&:created_at).last
      last_updated = purchases.sort_by(&:updated_at).last
      
      last_updated.creation_status =
        last_updated.updated_at > last_updated.created_at ? :updated : :created
    end
    
    purchases
  end

end
