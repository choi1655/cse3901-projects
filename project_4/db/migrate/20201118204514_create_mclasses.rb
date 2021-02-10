class CreateMclasses < ActiveRecord::Migration[6.0]
  def change
    create_table :mclasses do |t|
      t.integer :number
      t.integer :section
      t.string :days
      t.string :time
      t.string :location
      t.integer :enrolled
      t.integer :limit
      t.integer :waitlist
      t.string :instructor
      t.string :campus
      t.boolean :need_grader

      t.timestamps
    end
  end
end
