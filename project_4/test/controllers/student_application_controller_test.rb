require 'test_helper'

class StudentApplicationControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get student_application_index_url
    assert_response :success
  end

end
