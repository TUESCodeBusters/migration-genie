class CreateSightings < ActiveRecord::Migration[5.0]
  def change
    create_table :sightings do |t|
      t.datetime :capturedOn
      t.integer :objects

      t.timestamps
    end
  end
end
