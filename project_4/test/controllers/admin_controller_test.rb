require 'test_helper'

class AdminControllerTest < ActionDispatch::IntegrationTest
  test "should get applications" do
    get admin_applications_url
    assert_response :success
  end

  test "should get users" do
    get admin_users_url
    assert_response :success
  end

  test "should get classes" do
    get admin_classes_url
    assert_response :success
  end

end
