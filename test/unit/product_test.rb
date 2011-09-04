require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test "factory should be valid" do
    assert build(:product).valid?
  end
  
  test "should destroy dependent purchases" do
    product = create(:product)
    2.times { create(:purchase, :product_id => product.id) }
    
    assert_difference "Purchase.count", -2 do
      product.destroy
    end
  end
  
  
  test "should count purchases correctly" do
    product = create(:product)
    3.times { |x| create(:purchase, :product_id => product.id, :quantity => x+1) }
    
    assert_equal 6, product.purchase_count
  end
  
  test "should get baskets correctly" do
    product, purchases, baskets = product_purchased_in_multiple_baskets    
    
    assert_equal 2, product.baskets.length
  end
  
  private
  
  def product_purchased_in_multiple_baskets
    product = create(:product)
    other_product = create(:product)
    
    baskets = []
    2.times { baskets << create(:basket) }
    
    baskets.each do |basket|
      basket.purchases << create(:purchase, :product_id => product.id)
      basket.purchases << create(:purchase, :product_id => other_product.id)      
    end
    
    baskets << create(:basket)
    
    purchases = baskets.map(&:purchases).flatten
    
    [ product, purchases, baskets ]
  end
  
end