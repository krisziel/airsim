class AircraftsController < ApplicationController

  def all
    @aircraft = Aircraft.all
    render json: @aircraft
  end

end
