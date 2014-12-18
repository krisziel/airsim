class AddCodesToAirport < ActiveRecord::Migration
  def change
    add_column :airports, :region_name, :string
    add_column :airports, :country_code, :string
  end
end
