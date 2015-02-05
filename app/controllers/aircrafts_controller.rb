class AircraftsController < ApplicationController

  def all
    aircraft = Aircraft.all
    aircraft_list = {}
    aircraft.each do |aircraft|
      aircraft_list[aircraft.id] = {
        :id => aircraft.id,
        :name => aircraft.name,
        :manufacturer => aircraft.manufacturer,
        :iata => aircraft.iata,
        :capacity => aircraft.capacity,
        :speed => aircraft.speed,
        :range => aircraft.range,
        :turn_time => aircraft.turn_time,
        :price => aircraft.price,
        :discount => aircraft.discount,
        :fuel_capacity => aircraft.fuel_capacity,
        :sqft => aircraft.sqft
      }
    end
    render json: aircraft_list
  end

  def airline
    airline_id = 1
    aircraft_list = {}
    aircraft = UserAircraft.where(:airline_id => airline_id)
    aircraft.each do |aircraft|
      type = aircraft.aircraft
      flight = Flight.where(:user_aircraft_id => aircraft.id)
      if flight.length > 0
        flightData = {
          :flightId => flight[0].id,
          :routeId => flight[0].route_id,
          :origin => Airport.find(flight[0].route.origin_id).iata,
          :destination => Airport.find(flight[0].route.destination_id).iata,
        }
      else
        flightData = {
          :flightId => nil,
          :routeId => nil,
          :origin => nil,
          :destination => nil
        }
      end
      aircraft_list[aircraft.id] = {
        :age => aircraft.age,
        :config => JSON.parse(aircraft.aircraft_config),
        :type => {
          :name => type.name,
          :manufacturer => type.manufacturer,
          :fullName => type.full_name,
          :id => type.id,
          :iata => type.iata,
          :range => type.range
        },
        :inuse => aircraft.inuse,
        :id => aircraft.id,
        :flight => flightData
      }
    end
    render json: aircraft_list
  end

  def buy
    airline_id = 1
    airline = Airline.find(airline_id)
    money = airline.money
    aircraft = Aircraft.find(params[:id])
    if aircraft.price*params[:quantity] > money
    else
    end
  end

end
