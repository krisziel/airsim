class Flight < ActiveRecord::Base
  belongs_to :aircraft
  belongs_to :user_aircraft
  belongs_to :route
  belongs_to :airline

  def basic_aircraft_data
    aircraft = user_aircraft.aircraft
    user_ac = {
      :id => user_aircraft.id,
      :type => {
        :name => aircraft.name,
        :manufacturer => aircraft.manufacturer,
        :iata => aircraft.iata,
        :id => aircraft.id,
        :fullName => aircraft.full_name
      }
    }
    user_ac
  end

  def aircraft_data
    aircraft = user_aircraft.aircraft
    user_ac = {
      :id => user_aircraft.id,
      :config => JSON.parse(user_aircraft.aircraft_config),
      :type => {
        :name => aircraft.name,
        :manufacturer => aircraft.manufacturer,
        :iata => aircraft.iata,
        :id => aircraft.id,
        :range => aircraft.range,
        :fullName => aircraft.full_name
      }
    }
    user_ac
  end

  def load_factor
    total_seats = 0
    occupied = 0
    occupancy = JSON.parse(loads)
    seats = JSON.parse(user_aircraft.aircraft_config)
    seats.each_key do |key|
      occupied += ((occupancy[key]*0.01)*seats[key]["seats"])
      total_seats += seats[key]["seats"]
    end
    load_data = {
      :available => total_seats,
      :occupied => occupied,
      :factor => (100*occupied/total_seats).round(1)
    }
    load_data
  end

end
#
# t.integer  "route_id"
# t.string   "user_aircraft_id"
# t.integer  "duration"
# t.string   "amenities"
# t.integer  "frequencies"
# t.string   "fare"
# t.integer  "rating"
# t.integer  "distance"
# t.integer  "passengers"
# t.integer  "revenue"
# t.integer  "cost"
# t.integer  "airline_id"
# t.integer  "game_id"
# t.datetime "created_at"
# t.datetime "updated_at"
# t.string   "loads"
# t.string   "profit"
# t.integer  "airline_id"
# t.integer  "aircraft_id"
# t.integer  "age"
# t.boolean  "inuse"
# t.datetime "created_at"
# t.datetime "updated_at"
# t.string   "aircraft_config"
