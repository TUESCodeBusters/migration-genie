class AddLocationToSightings < ActiveRecord::Migration[5.0]
  def change
    add_reference :sightings, :location, foreign_key: true
  end
end
