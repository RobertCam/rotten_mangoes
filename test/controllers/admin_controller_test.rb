require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  test "should get user" do
    get :user
    assert_response :success
  end

end
