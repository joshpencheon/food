require 'test_helper'

class PurchaseTest < ActiveSupport::TestCase
  test "factory should be valid" do
    assert build(:purchase).valid?
  end
  
  test "purchase should calculate cost correctly with no saving" do
    purchase = build(:purchase, :unit_price => 2, :quantity => 3)
    
    assert_equal 2 * 3, purchase.cost
  end
  
  test "purchase should calculate cost correctly with saving" do
    purchase = build(:purchase, :unit_price => 2, :quantity => 3, :saving => 1)
    
    assert_equal 2 * 3 - 1, purchase.cost
  end
  
  test "purchase should update quantity & saving instead of creating if has been made already" do
    basket = build(:basket).save
    
    first_purchase  = build(:purchase, :unit_price => 2, :quantity => 3, :saving => 2, :basket_id => basket.id)
    second_purchase = build(:purchase, :unit_price => 2, :quantity => 2, :saving => 1, :basket_id => basket.id)
    
    first_purchase.save
    second_purchase.save
    
    assert_equal 5, first_purchase.quantity
    assert_equal 3, first_purchase.saving
    
    assert_equal first_purchase.id, second_purchase.id
  end
end
