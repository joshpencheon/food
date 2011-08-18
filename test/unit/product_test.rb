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
  
end
