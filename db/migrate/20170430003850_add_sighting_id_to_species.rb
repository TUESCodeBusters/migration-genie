class AddSightingIdToSpecies < ActiveRecord::Migration[5.0]
  def change
    add_column :species, :sighting_id, :integer
  end
end
