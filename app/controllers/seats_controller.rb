class SeatsController < ApplicationController

  def all
    seats = Seat.all
    seatslist = {}
    seats.each do |seat|
      seatslist[seat.id] = {
        :id => seat.id,
        :name => seat.name,
        :cost => seat.cost,
        :rating => seat.rating,
        :sqft => seat.sqft
      }
    end
    render json: seatslist
  end

end
