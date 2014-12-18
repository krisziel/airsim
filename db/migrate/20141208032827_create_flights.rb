class CreateFlights < ActiveRecord::Migration
  def change
    create_table :flights do |t|
      t.integer :route_id
      t.string :user_aircraft_id
      t.integer :duration
      t.string :amenities
      t.integer :frequencies
      t.string :fare
      t.integer :rating
      t.integer :distance
      t.integer :passengers
      t.integer :integer
      t.integer :revenue
      t.integer :cost
      t.integer :user_id
      t.integer :game_id
      t.integer :aircraft_id
    end
  end
end
