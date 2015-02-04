class Airport < ActiveRecord::Base
  attr_accessor :routes, :flights, :fares

  def basic_data
    airport = {
      :iata => iata,
      :name => name,
      :city => city
    }
    airport
  end
  
  # def count airport
  #   routes = Route.where("origin=? OR destination=?", airport.id, airport.id)
  #   count = 0
  #   routes.each do |route|
  #     flights = Flight.where(:route_id => route.id)
  #     flights.each do |flight|
  #       count += flight.frequencies
  #     end
  #   end
  #   return count
  # end
end
