class CreateAircraftCapacity < ActiveRecord::Migration
  def change
    create_table :aircraft_capacities do |t|
      t.integer :aircraft_id
      t.integer :capacity
      t.integer :class_config
      t.timestamps
    end
  end
end
