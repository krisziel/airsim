class AllAirport < ActiveRecord::Base
  validates_uniqueness_of :iata
end
