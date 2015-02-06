class AirlineController < ApplicationController

  def login
    if !cookies.signed[:airlineid]
      render json: {:error => 'no airline'}
    else
      airline = Airline.find(cookies.signed[:airlineid])
      if airline
        render json: airline
      else
        render json: {:error => 'airline not found'}
      end
    end
  end

  def create
    params[:airline][:money] = 5000000000
    params[:airline][:game_id] = 1
    airline = Airline.create(airline_params)
    if(airline)
      cookies.signed[:airlineid] = {
        value: airline.id,
        expires: 1.month.from_now
      }
      render json: airline
    else
      render json: {:error => 'error creating airline'}
    end
  end

  def list
    airlines = []
    airline_list = Airline.where(:game_id => Airline.find(cookies.signed[:airlineid]).game_id)
    airline_list.each do |airline|
      airline = {
        :name => airline.name,
        :iata => airline.iata,
        :id => airline.id
      }
      airlines.push(airline)
    end
    render json: airlines
  end

  private
  def airline_params
    params.require(:airline).permit(:iata, :name, :money, :game_id)
  end

end
