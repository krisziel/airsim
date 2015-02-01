class RoutesController < ApplicationController

  def all
    flights = Flight.all
    # flights = Flight.where(:user_id => user_id)
    @routes = {}
    flights.each do |flight|
      if @routes[flight.route_id]
        @routes[flight.route_id][:flights].push(flight)
      else
        @routes[flight.route_id] = {
          :route => Route.find(flight.route_id),
          :flights => [flight]
        }
      end
    end
    render json: @routes
  end

  def info
    @routes = Route.where("(origin_id == ? AND destination_id == ?) OR (origin_id == ? AND destination_id == ?)",params[:origin],params[:destination],params[:destination],params[:origin])
    render json: @routes
  end

end
