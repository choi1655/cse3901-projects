json.extract! recommendation_form, :id, :instructor_id, :content, :application_id, :created_at, :updated_at
json.url recommendation_form_url(recommendation_form, format: :json)
