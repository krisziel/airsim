class AircraftsController < ApplicationController
  before_action :current_airline

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
    airline_id = current_airline.id
    aircraft_list = {}
    aircraft = UserAircraft.where(:airline_id => airline_id)
    aircraft.each do |aircraft|
      aircraft_list[aircraft.id] = (full_user_aircraft aircraft)
    end
    render json: aircraft_list
  end

  def buy
    airline_id = current_airline.id
    airline = Airline.find(airline_id)
    money = airline.money
    aircraft = Aircraft.find(params[:aircraft_id].to_i)
    quantity = params[:quantity].to_i
    discount = [((quantity-1)*aircraft.discount),50].min
    price = (aircraft.price*(1-(discount*0.01)))
    if price*quantity > money
      quantity = (money/price).floor
    end
    if quantity > 0
      purchases = []
      airline_money = airline.money
      quantity.times do |i|
        airline_money -= price
        user_aircraft = UserAircraft.create!({
          :airline_id => airline_id,
          :aircraft_id => params[:aircraft_id],
          :age => 0,
          :inuse => false,
          :aircraft_config => params[:config]
        })
        if user_aircraft
          airline.update(:money => airline_money)
        end
        purchases.push(full_user_aircraft(user_aircraft))
      end
      render json: {
        :purchases => purchases,
        :airline => {
          :money => airline_money
        }
      }
    else
      render json: {
        :message => 'quantity must be more than 0'
      }
    end
  end

  private

  def full_user_aircraft aircraft
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
    data = {
      :age => aircraft.age,
      :config => JSON.parse(aircraft.aircraft_config),
      :type => {
        :name => type.name,
        :manufacturer => type.manufacturer,
        :fullName => type.full_name,
        :id => type.id,
        :iata => type.iata,
        :range => type.range,
        :speed => type.speed,
        :turn_time => type.turn_time
      },
      :inuse => aircraft.inuse,
      :id => aircraft.id,
      :flight => flightData
    }
    data
  end

end
