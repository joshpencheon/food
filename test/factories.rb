FactoryGirl.define do
  
  factory :shop do
    name 'tesco'
  end
  
  factory :basket do
    shop    
  end
  
  factory :purchase do
    quantity 1
    unit_price_in_pence 100
    product
    basket
  end
  
  factory :product do
    sequence(:name) { |n| "MyProduct#{n}" }
    sequence(:ean)  { |n| n.to_s.rjust(13, '0') }
  end
end