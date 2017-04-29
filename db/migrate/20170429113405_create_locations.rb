class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.datetime :checkedOn

      t.timestamps
    end
  end
end
