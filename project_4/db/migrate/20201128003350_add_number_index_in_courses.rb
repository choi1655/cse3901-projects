class AddNumberIndexInCourses < ActiveRecord::Migration[6.0]
  def change
    add_index :courses, :number
  end
end
