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
end
