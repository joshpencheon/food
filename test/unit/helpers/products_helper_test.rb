require 'test_helper'

class ProductsHelperTest < ActionView::TestCase

  test "ean_for should return a the ean of a product formatted correctly" do
    product = build(:product, :ean => 1234567891234)
    
    assert product.valid?
    assert_equal '1 234567 891234', ean_for(product)
  end
  
  test "ean_for should return a dummy string for a product without an ean" do
    product = build(:product, :ean => nil)
    
    assert_equal 'x xxxxxx xxxxxx', ean_for(product)
  end
  
  test "autocomplete_data_for should return the correctly formatted array" do
    products = [
      build(:product, :name => 'foo', :ean => 1234567891234),
      build(:product, :name => 'bar', :ean => 2234567891234)
    ]
    
    expected = [
      { 'product' => { :name => 'foo', :ean => '1 234567 891234' } },
      { 'product' => { :name => 'bar', :ean => '2 234567 891234' } },      
    ]
    
    assert_equal expected, autocomplete_data_for(products)
  end

end
