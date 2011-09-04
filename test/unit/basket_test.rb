require 'test_helper'

class BasketTest < ActiveSupport::TestCase
  test "factory should be valid" do
    assert build(:basket).valid?
  end
  
  test "basket total cost should be equal to sum of purchase costs" do
    basket = build(:basket)
    2.times { basket.purchases.create_or_update attributes_for(:purchase) }
    
    assert basket.purchases.any?
    assert_equal basket.purchases.map(&:cost).sum, basket.cost
  end
  
  test "should parse shop date correctly" do
    basket = build(:basket, :shop_date => '12/12/2010')
    
    assert_equal DateTime.new(2010, 12, 12), basket.shop_date
    assert basket.valid?
  end
  
  test "after validation, should have default shop_date of today" do
    basket = build(:basket)
    
    assert_nil basket.shop_date
    basket.valid?
    assert_equal Time.now.at_midnight, basket.shop_date
  end
  
  test "should be ignore rubbish shop_date" do
    basket = build(:basket, :shop_date => 'fubar')
    
    assert basket.shop_date.nil?
  end
end
