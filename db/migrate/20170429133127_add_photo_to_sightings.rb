class AddPhotoToSightings < ActiveRecord::Migration[5.0]
  def change
    add_column :sightings, :photo, :string
  end
end
