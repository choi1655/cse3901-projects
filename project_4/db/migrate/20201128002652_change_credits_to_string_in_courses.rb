class ChangeCreditsToStringInCourses < ActiveRecord::Migration[6.0]
  def change
    change_column :courses, :credits, :string
  end
end
