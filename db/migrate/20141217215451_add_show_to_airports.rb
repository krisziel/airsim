class AddShowToAirports < ActiveRecord::Migration
  def change
    add_column :airports, :display, :integer
  end
end
