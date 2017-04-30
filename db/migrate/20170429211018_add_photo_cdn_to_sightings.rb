class AddPhotoCdnToSightings < ActiveRecord::Migration[5.0]
  def change
    add_column :sightings, :photo_cdn, :string
  end
end
