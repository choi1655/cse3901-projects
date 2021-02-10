class CreateRecommendationForms < ActiveRecord::Migration[6.0]
  def change
    create_table :recommendation_forms do |t|
      t.string :instructor_id
      t.string :content
      t.string :application_id

      t.timestamps
    end
  end
end
