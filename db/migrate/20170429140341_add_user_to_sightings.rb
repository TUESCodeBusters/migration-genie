class AddUserToSightings < ActiveRecord::Migration[5.0]
  def change
    add_reference :sightings, :user, foreign_key: true
  end
end
