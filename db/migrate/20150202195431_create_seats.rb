class CreateSeats < ActiveRecord::Migration
  def change
    create_table :seats do |t|
      t.string :service_class
      t.string :name
      t.integer :cost
      t.integer :rating
      t.integer :sqft
      t.timestamps
    end
  end
end
