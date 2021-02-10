class AddCampusToCourses < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :campus, :string
  end
end
