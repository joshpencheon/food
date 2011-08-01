require 'test_helper'

class BasketsControllerTest < ActionController::TestCase
  
  test "visiting the index should be a success" do
    get :index
    assert_response :success
    assert_not_nil assigns(:baskets)
  end
  
  test "after creating a valid basket I should be shown it" do
    post :create, :basket => build(:basket).attributes
    assert assigns(:basket).valid?
    assert_redirected_to assigns(:basket)
  end
  
  test "after attempting to save an invalid basket, I should return to the form" do
    post :create, :basket => { :shop_id => nil }
    assert_response :success
    assert_equal 'Basket not valid', flash[:error]
  end
end
