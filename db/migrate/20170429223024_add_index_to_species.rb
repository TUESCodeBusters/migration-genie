class AddIndexToSpecies < ActiveRecord::Migration[5.0]
  def change
    add_index :species, :name, unique: true
  end
end
