class RoutesController < ApplicationController

  def all
    flights = Flight.all
    # flights = Flight.where(:airline_id => airline_id)
    @routes = {}
    flights.each do |flight|
      flightJSON = {
        :aircraft_id => flight.user_aircraft.aircraft_id,
        :cost => flight.cost,
        :distance => flight.distance,
        :duration => flight.duration,
        :fare => JSON.parse(flight.fare),
        :frequencies => flight.frequencies,
        :id => flight.id,
        :loads => JSON.parse(flight.loads),
        :profit => JSON.parse(flight.profit),
        :revenue => flight.revenue,
        :route_id => flight.route_id,
        :user_aircraft => flight.user_aircraft_id
      }
      route = Route.find(flight.route_id)
      routeJSON = {
        :id => route.id,
        :origin_id => route.origin_id,
        :destination_id => route.destination_id,
        :demand => {
          :total => route.demand,
          :unfilled => unfilled_demand(route.id)
        },
        :minfare => JSON.parse(route.minfare),
        :maxfare => JSON.parse(route.maxfare),
        :distance => route.distance
      }
      if @routes[flight.route_id]
        @routes[flight.route_id][:flights].push(flightJSON)
      else
        @routes[flight.route_id] = {
          :route => routeJSON,
          :flights => [flightJSON]
        }
      end
    end
    render json: @routes
  end

  def info
    @routes = Route.where("(origin_id == ? AND destination_id == ?) OR (origin_id == ? AND destination_id == ?)",params[:origin],params[:destination],params[:destination],params[:origin])
    render json: @routes
  end

  def distance
    routes = Route.all
    routes.each do |route|
      origin = Airport.find(route.origin_id)
      dest = Airport.find(route.destination_id)

      lat_a = origin.latitude.to_f
      lng_a = origin.longitude.to_f

      lat_b = dest.latitude.to_f
      lng_b = dest.longitude.to_f

      mi = (gcm_distance([lat_a, lng_a], [lat_b, lng_b])*0.621371)
      min = {
        :y => (mi*0.1*0.3).round,
        :p => (mi*0.3*0.3).round,
        :j => (mi*0.5*0.3).round,
        :f => (mi*1.0*0.3).round
      }
      max = {
        :y => (mi*0.1*2.0).round+1000,
        :p => (mi*0.3*2.0).round+1000,
        :j => (mi*0.5*2.0).round+1000,
        :f => (mi*1.0*2.0).round+1000
      }
      Route.find(route.id).update(minfare:min.to_json,maxfare:max.to_json,distance:mi)
    end
    render json:routes
  end

  def unfilled_demand id
  end

  def gcm_distance loc1, loc2
    lat1, lon1 = loc1
    lat2, lon2 = loc2
    dLat = (((lat2-lat1)*Math::PI) / 180);
    dLon = (((lon2-lon1)*Math::PI) / 180);
    a = Math.sin(dLat/2) * Math.sin(dLat/2) +
    Math.cos(lat1.to_rad) * Math.cos(lat2.to_rad) *
    Math.sin(dLon/2) * Math.sin(dLon/2);
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
    d = 6371 * c; # Multiply by 6371 to get Kilometers
  end

end
