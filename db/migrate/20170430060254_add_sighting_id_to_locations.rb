class AddSightingIdToLocations < ActiveRecord::Migration[5.0]
  def change
    add_column :locations, :sighting_id, :integer
  end
end
