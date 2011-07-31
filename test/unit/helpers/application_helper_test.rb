require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "format_price should fill in any trailing zeros" do
    assert_equal '£10.20', format_price(10.2)
    assert_equal '£10.00', format_price(10.0)
    assert_equal '£10.00', format_price(10)
  end
  
  test "format_price should by default drop the currency symbol" do
    assert_equal '£123.46', format_price(123.456)
  end
  
  test "format_price should not include the currency symbol with a truthy second argument" do
    assert_equal '£123.46', format_price(123.456, true)
  end
end
