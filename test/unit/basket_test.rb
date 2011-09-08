require 'test_helper'

class BasketTest < ActiveSupport::TestCase
  test "factory should be valid" do
    assert build(:basket).valid?
  end
  
  test "should have a complete bill after creation" do
    basket = create(:basket)
    
    assert basket.bills.any?
    assert_equal 100, basket.bills.first.proportion
  end
  
  test "should autosave any bills" do
    basket = create(:basket)
    basket.bills.build(:proportion => 50)
    
    assert basket.save
    assert_equal 2, basket.bills(true).length
  end
  
  test "should balance equally bills when proportions invalid" do
    basket = create(:basket)
    3.times { basket.bills.build(:proportion => 13) }
    basket.save
    basket.bills(true).each do |bill|
      assert_equal 25, bill.proportion
    end
  end
  
  test "should not balance bills with valid proportions" do
    basket = create(:basket)
    basket.bills.first.proportion = 97
    3.times { |x| basket.bills.build(:proportion => x) }
    basket.save
    basket.bills(true).each do |bill|
      assert bill.proportion != 25
    end
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
