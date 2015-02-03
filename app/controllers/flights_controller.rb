class FlightsController < ApplicationController

  def info
    flight = Flight.find(params[:id])
    user_ac = UserAircraft.find(flight.user_aircraft_id)
    ac_config = JSON.parse(user_ac.aircraft_config)
    ac_config.each do |key,value|
      seat = Seat.find(value['seat_id'])
      value = {
        :seats => value['seats'],
        :seat => {
          :name => seat.name,
          :rating => seat.rating
        }
      }
      ac_config[key] = value
    end
    user_aircraft = {
      :id => user_ac.id,
      :age => user_ac.age,
      :aircraft_config => ac_config
    }
    full_aircraft = {
      :type => flight.aircraft,
      :config => user_aircraft
    }
    full_flight = {
      :route_id => flight.route_id,
      :duration => flight.duration,
      :frequencies => flight.frequencies,
      :performance => {
        :load => JSON.parse(flight.loads),
        :profit => JSON.parse(flight.profit),
        :fare => JSON.parse(flight.fare)
      },
      :revenue => flight.revenue,
      :cost => flight.cost,
      :aircraft => full_aircraft,
      :route => {
        :minFare => JSON.parse(flight.route.minfare),
        :maxFare => JSON.parse(flight.route.maxfare),
        :distance => flight.route.distance
      }
    }
    render json: full_flight
  end

end
