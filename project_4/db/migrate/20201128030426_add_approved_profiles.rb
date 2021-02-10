class AddApprovedProfiles < ActiveRecord::Migration[6.0]
  def change
  	add_column :profiles, :approved, :boolean
  end
end
