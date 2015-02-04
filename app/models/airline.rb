class Airline < ActiveRecord::Base
  belongs_to :user
  belongs_to :game
  has_many :flights
  has_many :user_aircrafts

  def basic_data
    airline = {
      :name => name,
      :iata => iata,
      :hub => hub
    }
  end

end
