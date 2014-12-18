class CreateAirports < ActiveRecord::Migration
  def change
    create_table :airports do |t|
      t.string :iata
      t.string :icao
      t.string :citycode
      t.string :name
      t.string :city
      t.string :state
      t.string :country
      t.integer :population
      t.integer :slots_total
      t.integer :slots_available
      t.string :latitude
      t.string :longitude
      t.integer :business_demand
      t.integer :leisure_demand
    end
  end
end
