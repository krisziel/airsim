require 'flightstats'

FlightStats.app_id = ENV['FSID']
FlightStats.app_key = ENV['FSKEY']
FlightStats.logger = Rails.logger
