class Flight < ActiveRecord::Base
  belongs_to :aircraft
  belongs_to :user_aircraft
  belongs_to :route

  def count airport
    routes = Route.where("origin=? OR destination=?", airport.id, airport.id)
    count = 0
    routes.each do |route|
      flights = Flight.where(:route_id => route.id)
      flights.each do |flight|
        count += flight.frequencies
      end
    end
    return count
  end
end
