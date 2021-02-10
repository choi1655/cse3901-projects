class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.integer :number
      t.string :title
      t.decimal :credits

      t.timestamps
    end
  end
end
