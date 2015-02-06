class DemandController < ApplicationController

  def turn
    all_flights = []
    flights = Flight.all
    flights.each do |flight|
      if flight.user_aircraft
        route = flight.route
        seats = JSON.parse(flight.user_aircraft.aircraft_config)
        fares = JSON.parse(flight.fare)
        demand = {
          "f" => route.demand_f,
          "j" => route.demand_j,
          "p" => route.demand_p,
          "y" => route.demand_y
        }
        demand_price = {
          "f" => route.price_f,
          "j" => route.price_j,
          "p" => route.price_p,
          "y" => route.price_y
        }
        available_seats = 0
        seats.each do |seat|
          available_seats += seat[1]['seats']
          seat[1]['seats'] = seat[1]['seats']*flight.frequencies
        end
        flight_data = {
          :cost => (flight.route.distance*available_seats*0.16*2*flight.frequencies).round
        }
        total_revenue = 0
        revenue = {}
        profit = {}
        loads = {}
        fares.each do |key,value|
          value = value.to_i
          if value == demand_price[key]
            occupied = [demand[key],seats[key]['seats']].min
          elsif value < demand_price[key]
            occupied = [demand[key]*((demand_price[key]/value)*1.01),seats[key]['seats']].min
          elsif value > demand_price[key]
            occupied = [demand[key]*((demand_price[key]/value)*1.02),seats[key]['seats']].min
          end
          seats[key]['seats'] > 0 ? load_factor = (occupied*1.0/seats[key]['seats']*1.0) : load_factor = 0
          class_rev = occupied*fares[key].to_i
          revenue[key] = class_rev.round
          loads[key] = (load_factor*100).round
          total_revenue += class_rev.round
        end
        flight_data[:profit] = revenue.to_json
        flight_data[:loads] = loads.to_json
        flight_data[:revenue] = total_revenue
        flight.update(flight_data)
        all_flights.push(flight_data)
      end
    end
    render json: all_flights
  end

end
