class UserAircraft < ActiveRecord::Base
  belongs_to :aircraft
  belongs_to :airline

  def config
    config = JSON.parse(aircraft_config)
    full_config = {
      :f => {
        :seats => config["f"]["seats"],
        :seat_id => config["f"]["seat_id"],
        :name => Seat.find(config["f"]["seat_id"]).name
      },
      :j => {
        :seats => config["j"]["seats"],
        :seat_id => config["j"]["seat_id"],
        :name => Seat.find(config["j"]["seat_id"]).name
      },
      :p => {
        :seats => config["p"]["seats"],
        :seat_id => config["p"]["seat_id"],
        :name => Seat.find(config["p"]["seat_id"]).name
      },
      :y => {
        :seats => config["y"]["seats"],
        :seat_id => config["y"]["seat_id"],
        :name => Seat.find(config["y"]["seat_id"]).name
      }
    }
  end

end
