module MergePurchasesExtension
  def create_or_update(params)
    new_record = build(params)
    
    if other = find_for_merge(new_record)
      other.merge_with(new_record).save
      update_log[other.id] = :updated
      other
    else
      new_record.save        
      update_log[new_record.id] = :created
      new_record
    end
  end
  
  def update_log
    @update_log ||= {}
  end
  
  private
    
  def find_for_merge(purchase)
    other_purchases = proxy_association.owner.purchases - [ purchase ]
    other_purchases.detect do |other| 
      other.product_id == purchase.product_id && 
        other.unit_price_in_pence == purchase.unit_price_in_pence
    end
  end
end