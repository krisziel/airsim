class FlightsController < ApplicationController

  def all
    @airline_id = 1
    flights = []
    flightarr = Flight.where(:airline_id => @airline_id)
    flightarr.each do |flight|
      flight = {
        :route_id => flight.route_id,
        :origin => {
          :iata => Airport.find(flight.route.origin_id).iata,
          :id => flight.route.origin_id
        },
        :destination => {
          :iata => Airport.find(flight.route.destination_id).iata,
          :id => flight.route.destination_id
        },
        :frequencies => flight.frequencies,
        :id => flight.id,
        :revenue => flight.revenue,
        :cost => flight.cost,
        :aircraft => flight.basic_aircraft_data,
        :load_factor => flight.load_factor
      }
      flights.push(flight)
    end
    render json: flights
  end

  def info *id
    id = params[:id] || id
    flight = Flight.find(id)
    flight.class == Array ? flight = flight[0] : flight = flight
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
    flight.loads ? loads = JSON.parse(flight.loads) : loads = {}
    full_flight = {
      :id => flight.id,
      :route_id => flight.route_id,
      :duration => flight.duration,
      :frequencies => flight.frequencies,
      :performance => {
        :load => loads,
        :profit => JSON.parse(flight.profit),
        :fare => JSON.parse(flight.fare)
      },
      :revenue => flight.revenue,
      :cost => flight.cost,
      :aircraft => flight.aircraft_data,
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
      render json: flight_data
    else
      flight = Flight.new(flight_data)
      if flight.save
        UserAircraft.find(flight_data[:user_aircraft_id]).update(:inuse => true)
        info flight.id
      else
      end
    end
  end

  def update
    Flight.find(params[:flight][:id]).user_aircraft.update(:inuse => false)
    flight_data = validate_flight flight_params, "update"
    if flight_data.class == Array
      render json: flight_data
    else
      flight = Flight.find(flight_data[:id])
      flight.user_aircraft.update(:inuse => false)
      if flight.update(flight_data)
        # UserAircraft.find(flight_data[:user_aircraft_id]).update(:inuse => true)
        info flight_data[:id]
      else
        flight_data = {:error => "error saving route",:routeid => flight_data[:id]}
        render json: flight_data
      end
    end
  end

  def delete
    flight = Flight.find(params[:id])
    UserAircraft.find(flight.user_aircraft_id).update(:inuse => false)
    flight.user_aircraft.inuse = false
    flight.delete
    render json: flight
  end

  private

  def flight_params
    params.require(:flight).permit(:route_id, :user_aircraft_id, :fare, :frequencies, :id)
  end

  def validate_flight data, type
    flight = {}
    errors = []
    empty_class = {
      :f => 0,
      :j => 0,
      :p => 0,
      :y => 0
    }
    empty_class = empty_class.to_json
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
      user_aircraft = get_user_aircraft data[:user_aircraft_id], type, data[:id]
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
    if type == "new"
      flight[:loads] = empty_class
      flight[:profit] = empty_class
    end
    if errors.length > 0
      errors
    else
      flight
    end
  end

  def get_route route_id
    route_content = Route.find(route_id)
    route = {}
    if route
      route[:valid] = true
      route[:id] = route_id
      route[:distance] = route_content.distance
    else
      route[:valid] = false
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
        flight.class == Array ? flight = flight[0] : flight = flight
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

end
