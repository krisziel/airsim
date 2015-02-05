class Flight < ActiveRecord::Base
  belongs_to :aircraft
  belongs_to :user_aircraft
  belongs_to :route
  belongs_to :airline

  validates_uniqueness_of :user_aircraft_id

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
      :config => user_aircraft.config,
      :type => {
        :name => aircraft.name,
        :manufacturer => aircraft.manufacturer,
        :iata => aircraft.iata,
        :id => aircraft.id,
        :range => aircraft.range,
        :turn_time => aircraft.turn_time,
        :fullName => aircraft.full_name
      }
    }
    user_ac
  end

  def load_factor
    total_seats = 0
    occupied = 0
    if loads
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
    else
      load_data = {}
    end
    load_data
  end

end
