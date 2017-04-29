class AddLocationToSpecies < ActiveRecord::Migration[5.0]
  def change
    add_reference :species, :location, foreign_key: true
  end
end
