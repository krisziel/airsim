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
    # airportsarr = Airport.where(:display => 1)
    airportlist = []
    airportsarr = AllAirport.where('iata IN (?)',['YUL','TPA','JAX','AMA','TUS','PHL','PIT','ATL','CMH','SAT','AUS','SJD','DXB','AUH','SIN','KWI','BAH','DOH','KUL','SYD','GLA','MEL','PER','HKG','MFM','ICN','NRT','ROR','YCG','RAN','TIS','STU','NNI','NGO','PEK','PVG','HNL','KOA','OGG','LIH','AKL','GUM','ANC','SEA','PDX','SMF','SFO','SJC','LAX','SAN','PHX','LAS','MEX','GRU','GIG','SCL','EZE','PTY','IAH','DFW','ABQ','RNO','DEN','ORD','YVR','YYC','ZRH','YOW','YYT','BOS','JFK','EWR','IAD','RDU','CLT','MIA','MCO','FLL','MSY','OMA','DTW','MSP','CLE','MEM','BOI','OKC','BZN','FAR','TIJ','PVR','CUN','EDI','SNN','LHR','MAN','CDG','FRA','MUC','TXL','VIE','IST','CAI','TLV','DME','COS','CGK','MLE','DOM','DEL','BKK','FUK','KIX','GUM','FCO','BCN','MXP','TPE','TBS','AMS','BRU','GVA'])
    airportsarr.each do |airport|
      routes = Route.where("origin_id=? OR destination_id=?", airport.id, airport.id).length
      flights = Flight.count(airport.id)
      airportlist << "{iata:\"#{airport.iata}\",citycode:\"#{airport.citycode}\",name:\"#{airport.name}\",city:\"#{airport.city}\",country:\"#{airport.country}\",country_code:\"#{airport.country_code}\",region_name:\"#{airport.region_name}\",population:1000000,slots_total:1989,slots_available:1213,latitude:#{airport.latitude},longitude:#{airport.longitude}, display:1}"
    end
    render html: "Airport.create([#{airportlist.join(',')}])"
  end

end
