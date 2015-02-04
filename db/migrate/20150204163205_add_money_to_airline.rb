class AddMoneyToAirline < ActiveRecord::Migration
  def change
    add_column :airlines, :money, :integer
  end
end
