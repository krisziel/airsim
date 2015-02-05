class CreateAllAirports < ActiveRecord::Migration
  def change
    create_table :all_airports do |t|
      t.string :iata
      t.string :icao
      t.string :citycode
      t.string :name
      t.string :city
      t.string :state
      t.string :country
      t.string :latitude
      t.string :longitude
      t.string :country_code
      t.string :region_name
      t.timestamps
    end
  end
end
