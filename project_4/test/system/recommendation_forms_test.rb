require "application_system_test_case"

class RecommendationFormsTest < ApplicationSystemTestCase
  setup do
    @recommendation_form = recommendation_forms(:one)
  end

  test "visiting the index" do
    visit recommendation_forms_url
    assert_selector "h1", text: "Recommendation Forms"
  end

  test "creating a Recommendation form" do
    visit recommendation_forms_url
    click_on "New Recommendation Form"

    fill_in "Application", with: @recommendation_form.application_id
    fill_in "Content", with: @recommendation_form.content
    fill_in "Instructor", with: @recommendation_form.instructor_id
    click_on "Create Recommendation form"

    assert_text "Recommendation form was successfully created"
    click_on "Back"
  end

  test "updating a Recommendation form" do
    visit recommendation_forms_url
    click_on "Edit", match: :first

    fill_in "Application", with: @recommendation_form.application_id
    fill_in "Content", with: @recommendation_form.content
    fill_in "Instructor", with: @recommendation_form.instructor_id
    click_on "Update Recommendation form"

    assert_text "Recommendation form was successfully updated"
    click_on "Back"
  end

  test "destroying a Recommendation form" do
    visit recommendation_forms_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Recommendation form was successfully destroyed"
  end
end
