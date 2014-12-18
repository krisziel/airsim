class CreateAircraft < ActiveRecord::Migration
  def change
    create_table :aircrafts do |t|
      t.string :name
      t.string :manufacturer
      t.string :iata
      t.integer :capacity
      t.integer :speed
      t.integer :turn_time
      t.integer :price
      t.integer :discount
      t.integer :fuel_capacity
      t.integer :hourly_cost
      t.integer :range
      t.integer :cargo
    end
  end
end
