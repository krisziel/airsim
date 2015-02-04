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
      :id => flight.user_aircraft_id,
      :type => flight.user_aircraft.aircraft,
      :config => user_aircraft
    }
    full_flight = {
      :id => flight.id,
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

  def create
    flight_data = validate_flight flight_params, "new"
    if flight_data.class == Array
    else
      flight = Flight.new(flight_data)
      UserAircraft.find(flight_data[:user_aircraft_id]).update(:inuse => true)
      flight_data[:save] = flight.save
    end
    render json: flight_data
  end

  def update
    flight_data = validate_flight flight_params, "update"
    if flight_data.class == Array
    else
      p flight_data
      flight_data[:save] = Flight.find(flight_data[:id]).update(flight_data)
    end
    render json: flight_data
  end

  private

  def flight_params
    params.require(:flight).permit(:route_id, :user_aircraft_id, :fare, :frequencies, :id)
  end

  def get_route route_id
    route_content = Route.find(route_id)
    route = {}
    if route
      route[:valid] = true
      route[:id] = route_id
      route[:distance] = route_content.distance
    else
      route[:value] = false
    end
    route
  end

  def get_user_aircraft aircraft_id, type, *flight_id
    aircraft = UserAircraft.find(aircraft_id)
    user_aircraft = {}
    if aircraft.inuse
      if type == "new"
        error = true
      else
        flight = Flight.find(flight_id)
        if flight.user_aircraft_id == aircraft_id
          error = false
        else
          error = true
        end
      end
    end
    if error
      user_aircraft[:valid] = false
      user_aircraft[:code] = 811
      user_aircraft[:message] = "aircraft in use"
    else
      user_aircraft[:valid] = true
      user_aircraft[:id] = aircraft_id
      user_aircraft[:speed] = aircraft.aircraft.speed
      user_aircraft[:range] = aircraft.aircraft.range
      user_aircraft[:airline] = aircraft.airline
    end
    user_aircraft
  end

  def validate_flight data, type
    flight = {}
    errors = []
    route = get_route data[:route_id]
    if route[:valid]
      flight[:route_id] = route[:id]
      flight[:distance] = route[:distance]
    else
      errors.push({
        :route_id => route[:id],
        :code => 810,
        :message => "invalid route id"
        })
    end
    if type == "new"
      user_aircraft = get_user_aircraft data[:user_aircraft_id], type
    else
      user_aircraft = get_user_aircraft data[:user_aircraft_id], type, data[:flight_id]
      flight[:id] = data[:id]
    end
    if user_aircraft[:valid]
      flight[:user_aircraft_id] = data[:user_aircraft_id].to_i
    else
      errors.push({
        :user_aircraft_id => data[:user_aircraft_id],
        :code => user_aircraft[:code],
        :message => user_aircraft[:message]
      })
      return errors
    end
    if user_aircraft[:range] >= flight[:distance]
      duration = 40
      duration += ((flight[:distance]/user_aircraft[:speed])*60).round
      flight[:duration] = duration
      max_frequencies = (10080/(flight[:duration]*2))
      if data[:frequencies].to_i > max_frequencies
        flight[:frequencies] = max_frequencies
      else
        flight[:frequencies] = data[:frequencies]
      end
    else
      error.push({
        :user_aircraft_id => user_aircraft_id,
        :code => 812,
        :message => "inadequate aircraft range"
      })
    end
    flight[:fare] = data[:fare]
    flight[:airline_id] = user_aircraft[:airline].id
    flight[:game_id] = user_aircraft[:airline].game_id
    if errors.length > 0
      errors
    else
      flight
    end
  end

end
