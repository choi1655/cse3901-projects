class AddAttrToInstructor < ActiveRecord::Migration[6.0]
  def change
    add_column :instructors, :profile_id, :string
    add_column :instructors, :class_num, :string
    add_column :instructors, :class_section, :string
  end
end
