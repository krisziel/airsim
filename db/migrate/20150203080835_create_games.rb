class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :year
      t.integer :month
      t.integer :airlines
      t.string :region
      t.timestamps
    end
  end
end
