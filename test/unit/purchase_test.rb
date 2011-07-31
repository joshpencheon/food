require 'test_helper'

class PurchaseTest < ActiveSupport::TestCase
  test "factory should be valid" do
    assert build(:purchase).valid?
  end
  
  test "purchase should calculate cost correctly with no saving" do
    purchase = build(:purchase, :unit_price_in_pence => 200, :quantity => 3)
    
    assert_equal 2.00 * 3, purchase.cost
  end
  
  test "purchase should calculate cost correctly with saving" do
    purchase = build(:purchase, :unit_price_in_pence => 200, :quantity => 3, :saving_in_pence => 100)
    
    assert_equal 2.00 * 3 - 1.00, purchase.cost
  end
  
  test "purchase should update quantity & saving instead of creating if has been made already" do
    basket = create(:basket)    
    product = create(:product)
        
    first_purchase  = build(:purchase,      :product_id => product.id, :unit_price_in_pence => 200,
                            :quantity => 3, :saving_in_pence => 200,   :basket_id => basket.id)
    first_purchase.save
    
    assert_equal 3, first_purchase.quantity
    assert_equal 2, first_purchase.saving

    second_purchase = build(:purchase,      :product_id => product.id, :unit_price_in_pence => 200,
                            :quantity => 2, :saving_in_pence => 100,   :basket_id => basket.id)
    
    second_purchase.save
    first_purchase.reload
    
    assert_equal 5, first_purchase.quantity
    assert_equal 3, first_purchase.saving
    
    basket.reload
    assert_equal 1, basket.purchases.length
  end

  test "new purchase should not save if it's quantity is 0" do
    purchase = build(:purchase, :quantity => 0)
    
    assert_no_difference "Purchase.count" do
      purchase.save
    end
  end
  
  test "existing purchase should remove itself if it's quantity is 0" do
    purchase = create(:purchase, :quantity => 1)
    
    assert_difference "Purchase.count", -1 do
      purchase.quantity = 0
      purchase.save
    end
  end
  
  test "should have default unit_price of nil" do
    purchase = build(:purchase, :unit_price_in_pence => nil)
    assert_nil purchase.unit_price
  end
  
  test "should have default saving of nil" do
    purchase = build(:purchase, :saving_in_pence => nil)
    assert_nil purchase.saving
  end
  
  test "should store unit_price & saving in pence correctly" do
    purchase = build(:purchase)
    
    def assert_prices_for(purchase, set_value, db_value, get_value = set_value)
      purchase.unit_price = set_value
      assert_equal db_value, purchase.unit_price_in_pence
      assert_equal get_value.class, purchase.unit_price.class
      assert_equal get_value, purchase.unit_price
      
      purchase.saving = set_value
      assert_equal db_value, purchase.saving_in_pence
      assert_equal get_value.class, purchase.saving.class
      assert_equal get_value, purchase.saving
    end
    
    assert_prices_for(purchase, 1.99,  199        )
    assert_prices_for(purchase, 1,     100,  1.00 )
    assert_prices_for(purchase, 0,     0,    0.00 )
    assert_prices_for(purchase, 0.995, 100,  1.00 )
    assert_prices_for(purchase, 10.2,  1020, 10.20)
        
  end
end
