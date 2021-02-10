require 'test_helper'

class InstructorViewControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get instructor_view_index_url
    assert_response :success
  end

end
