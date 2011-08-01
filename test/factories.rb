FactoryGirl.define do
  
  factory :shop do
    name 'tesco'
  end
  
  factory :basket do
    association :shop
  end
  
  factory :basket_with_purchases, :parent => :basket do
    purchases {|purchases| [purchases.association(:purchase), purchases.association(:purchase)]}
  end
  
  factory :purchase do
    quantity 1
    unit_price_in_pence 100
    product
  end
  
  factory :product do
    sequence(:name) { |n| "MyProduct#{n}" }
    sequence(:ean)  { |n| n.to_s.rjust(13, '0') }
  end
end