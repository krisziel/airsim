class RoutesController < ApplicationController
  require 'csv'

  def all
    flights = Flight.all
    # flights = Flight.where(:airline_id => airline_id)
    @routes = {}
    flights.each do |flight|
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
      @routes[flight.route_id] = routeJSON
    end
    render json: @routes
  end

  def info *id
    id = params[:id] || id
    route = Route.where("(id == ?) OR (origin_id == ? AND destination_id == ?) OR (origin_id == ? AND destination_id == ?)",id,params[:origin],params[:destination],params[:destination],params[:origin])[0]
    route = {
      :id => route.id,
      :origin_id => route.origin_id,
      :destination_id => route.destination_id,
      :distance => route.distance,
      :maxfare => JSON.parse(route.maxfare),
      :minfare => JSON.parse(route.minfare),
      :competitors => competitors(route.id),
      :own => own_flights(route.id)
    }
    render json: route
  end

  def competitors *id
    id = params[:id] || id
    airline_id = 1
    flights = []
    competitors = Flight.where("route_id = ? AND airline_id != ?", id, airline_id)
    competitors.each do |flight|
      flight = {
        :aircraft => flight.basic_aircraft_data,
        :fare => JSON.parse(flight.fare),
        :frequencies => flight.frequencies,
        :id => flight.id,
        :load_factor => flight.load_factor,
        :airline => flight.airline.basic_data
      }
      flights.push(flight)
    end
    flights
  end

  def own_flights *id
    id = params[:id] || id
    airline_id = 1
    flights = []
    competitors = Flight.where("route_id = ? AND airline_id == ?", id, airline_id)
    competitors.each do |flight|
      flight = {
        :aircraft => flight.aircraft_data,
        :cost => flight.cost,
        :frequencies => flight.frequencies,
        :id => flight.id,
        :load_factor => flight.load_factor,
        :revenue => flight.revenue
      }
      flights.push(flight)
    end
    flights
  end

  def distance id
    route = Route.find(id)
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
    route.update(minfare:min.to_json,maxfare:max.to_json,distance:mi)
  end

  def unfilled_demand id
  end

  def gcm_distance loc1, loc2
    lat1, lon1 = loc1
    lat2, lon2 = loc2
    dLat = (((lat2-lat1)*Math::PI) / 180);
    dLon = (((lon2-lon1)*Math::PI) / 180);
    a = Math.sin(dLat/2) * Math.sin(dLat/2) +
    Math.cos((lat1 * Math::PI / 180)) * Math.cos((lat2 * Math::PI / 180)) *
    Math.sin(dLon/2) * Math.sin(dLon/2);
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
    d = 6371 * c;
  end

  def parse_demand
    json = []
    CSV.foreach("public/us.csv") do |row|
      if row[6].class == String
        pax = row[6].gsub(/\,/,'')
      else
        pax = row[6]
      end
      if row[5].class == String
        fare = row[6].gsub(/\,/,'')
      else
        fare = row[6]
      end
      json.push({
        :origin => row[3],
        :destination => row[4],
        :pax => pax.to_f.ceil,
        :fare => fare.to_f.ceil
      })
    end
    routes = json
    new_json = []
    routes.each do |route|
      if route.class == Hash
        origin = Airport.where(:iata => route[:origin])
        dest = Airport.where(:iata => route[:destination])
        if origin.length == 0 || dest.length == 0

        else
          existingRoute = Route.where(:origin_id => dest[0].id, :destination_id => origin[0].id)
          if existingRoute.length == 0 && route[:pax] > 0 && route[:fare] > 0
            pax = route[:pax]
            fare = route[:fare]
            route_data = {
              :origin_id => origin[0].id,
              :destination_id => dest[0].id,
              :demand => pax,
              :demand_y => (pax*0.65),
              :price_y => (fare*0.65),
              :demand_p => (pax*0.15),
              :price_p => (fare*1.1),
              :demand_j => (pax*0.1),
              :price_j => (fare*1.5),
              :demand_f => (pax*0.1),
              :price_f => (fare*1.7)
            }
            new_route = Route.create!(route_data)
            new_json.push(new_route)
            distance new_route.id
          end
        end
      end
    end
    render json: new_json
  end

end
