class CreateRoute < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.integer :origin_id
      t.integer :destination_id
      t.integer :demand
      t.integer :demand_y
      t.integer :price_y
      t.integer :demand_p
      t.integer :price_p
      t.integer :demand_j
      t.integer :price_j
      t.integer :demand_f
      t.integer :price_f
      t.float :y_elasticity
      t.float :j_elasticity
      t.float :f_elasticity
    end
  end
end
