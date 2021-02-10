require 'test_helper'

class RecommendationFormsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @recommendation_form = recommendation_forms(:one)
  end

  test "should get index" do
    get recommendation_forms_url
    assert_response :success
  end

  test "should get new" do
    get new_recommendation_form_url
    assert_response :success
  end

  test "should create recommendation_form" do
    assert_difference('RecommendationForm.count') do
      post recommendation_forms_url, params: { recommendation_form: { application_id: @recommendation_form.application_id, content: @recommendation_form.content, instructor_id: @recommendation_form.instructor_id } }
    end

    assert_redirected_to recommendation_form_url(RecommendationForm.last)
  end

  test "should show recommendation_form" do
    get recommendation_form_url(@recommendation_form)
    assert_response :success
  end

  test "should get edit" do
    get edit_recommendation_form_url(@recommendation_form)
    assert_response :success
  end

  test "should update recommendation_form" do
    patch recommendation_form_url(@recommendation_form), params: { recommendation_form: { application_id: @recommendation_form.application_id, content: @recommendation_form.content, instructor_id: @recommendation_form.instructor_id } }
    assert_redirected_to recommendation_form_url(@recommendation_form)
  end

  test "should destroy recommendation_form" do
    assert_difference('RecommendationForm.count', -1) do
      delete recommendation_form_url(@recommendation_form)
    end

    assert_redirected_to recommendation_forms_url
  end
end
