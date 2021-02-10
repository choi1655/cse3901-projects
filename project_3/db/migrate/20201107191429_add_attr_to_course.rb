class AddAttrToCourse < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :section, :integer
    add_column :courses, :days, :string
    add_column :courses, :time, :string
    add_column :courses, :location, :string
    add_column :courses, :enrolled, :integer
    add_column :courses, :limit, :integer
    add_column :courses, :waitlist, :integer
    add_column :courses, :instructors, :string
  end
end
