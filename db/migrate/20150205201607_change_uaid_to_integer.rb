class ChangeUaidToInteger < ActiveRecord::Migration
  def change
    change_column :flights, :user_aircraft_id, :integer
  end
end
