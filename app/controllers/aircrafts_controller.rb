class AircraftsController < ApplicationController

  def all
    aircraft = Aircraft.all
    render json: aircraft
  end

  def airline
    airline_id = 1
    aircraft_list = {}
    aircraft = UserAircraft.where(:airline_id => airline_id)
    aircraft.each do |aircraft|
      aircraft_list[aircraft.id] = {
        :age => aircraft.age,
        :config => JSON.parse(aircraft.aircraft_config),
        :aircraft_id => aircraft.aircraft_id,
        :inuse => aircraft.inuse,
        :id => aircraft.id
      }
    end
    render json: aircraft_list
  end

end
