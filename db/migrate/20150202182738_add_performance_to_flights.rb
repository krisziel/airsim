class AddPerformanceToFlights < ActiveRecord::Migration
  def change
    add_column :flights, :loads, :string
    add_column :flights, :profit, :string

    add_column :aircrafts, :sqft, :integer

    add_column :user_aircrafts, :aircraft_config, :string

    rename_column :aircrafts, :hourly_cost, :fuel_burn

    add_column :routes, :p_elasticity, :float
  end
end
