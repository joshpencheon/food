require 'test_helper'

class BillTest < ActiveSupport::TestCase
  test "should by default have 0 proportion" do
    assert build(:bill).proportion.zero?
  end
end
