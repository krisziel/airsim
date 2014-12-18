class AppController < ApplicationController
  def index
    @airports = FlightStats::Airport.by_country_code 'SG'
    @airports.each do |airport|
      Airport.create(iata:airport.iata,icao:airport.icao,citycode:airport.city_code,name:airport.name,city:airport.city,state:airport.state_code,country:airport.country_name,country_code:airport.country_code,region_name:airport.region_name,latitude:airport.latitude,longitude:airport.longitude)
    end
  end
end
