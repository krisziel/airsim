class CreateClassTypes < ActiveRecord::Migration
  def change
    create_table :class_types do |t|
      t.string :name
      t.string :description
      t.string :type
      t.float :ratio
      t.float :premium
      t.float :cost
    end
  end
end
