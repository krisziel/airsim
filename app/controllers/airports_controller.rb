class AirportsController < ApplicationController

  def scrape
    airports = FlightStats::Airport.by_country_code params[:country]
    airports.each do |airport|
      AllAirport.create(iata:airport.iata,icao:airport.icao,citycode:airport.city_code,name:airport.name,city:airport.city,state:airport.state_code,country:airport.country_name,country_code:airport.country_code,region_name:airport.region_name,latitude:airport.latitude,longitude:airport.longitude)
    end
    render json: airports
  end

  def all
    airportsarr = Airport.where(display:1)
    airports = {}
    airportsarr.each do |airport|
      airportdata = {
        :id => airport.id,
        :iata => airport.iata,
        :citycode => airport.citycode,
        :name => airport.name,
        :city => airport.city,
        :country => airport.country,
        :population => airport.population,
        :slots_total => airport.slots_total,
        :slots_available => airport.slots_available,
        :latitude => airport.latitude,
        :longitude => airport.longitude,
        :routes => Route.where("origin_id=? OR destination_id=?", airport.id, airport.id).length,
        :flights => Flight.count(airport.id)
      }
      airports[airport['id']] = airportdata
    end
    render json: airports
  end

  def seed
    airportsarr = Airport.where(:display => 1)
    airportsarr.each do |airport|
      routes = Route.where("origin_id=? OR destination_id=?", airport.id, airport.id).length
      flights = Flight.count(airport.id)
      puts "Airport.create(iata:\"#{airport.iata}\",citycode:\"#{airport.citycode}\",name:\"#{airport.name}\",city:\"#{airport.city}\",country:\"#{airport.country}\",population:#{airport.population},slots_total:#{airport.slots_total},slots_available:#{airport.slots_available},latitude:#{airport.latitude},longitude:#{airport.longitude},routes:#{routes},flights:#{flights})"
    end
  end

end
