class AddSpeciesToSightings < ActiveRecord::Migration[5.0]
  def change
    add_reference :sightings, :species, foreign_key: true
  end
end
