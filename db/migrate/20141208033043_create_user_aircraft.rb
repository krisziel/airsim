class CreateUserAircraft < ActiveRecord::Migration
  def change
    create_table :user_aircrafts do |t|
      t.integer :airline_id
      t.integer :aircraft_id
      t.integer :age
      t.boolean :inuse
      t.timestamps
    end
  end
end
