class ChangeUaidToInteger < ActiveRecord::Migration
  def change
    change_column :flights, :user_aircraft_id, 'integer USING CAST(user_aircraft_id AS integer)'
  end
end
