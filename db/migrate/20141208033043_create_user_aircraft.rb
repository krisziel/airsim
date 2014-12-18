class CreateUserAircraft < ActiveRecord::Migration
  def change
    create_table :user_aircrafts do |t|
      t.integer :user_id
      t.integer :aircraft_id
      t.integer :age
      t.integer :seats_y
      t.integer :seats_p
      t.integer :seats_j
      t.integer :seats_f
    end
  end
end
