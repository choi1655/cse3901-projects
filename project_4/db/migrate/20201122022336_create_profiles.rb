class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.string :identity
      t.string :firstName
      t.string :lastName
      t.string :title

      t.timestamps
    end
  end
end
