class AddSightingsToSpecies < ActiveRecord::Migration[5.0]
  def change
    add_reference :species, :sightings, foreign_key: true
  end
end
