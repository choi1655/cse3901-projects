class CreateAssignments < ActiveRecord::Migration[6.0]
  def change
    create_table :assignments do |t|
      t.string :profile_id
      t.string :class_id

      t.timestamps
    end
  end
end
