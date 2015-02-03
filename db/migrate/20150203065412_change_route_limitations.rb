class ChangeRouteLimitations < ActiveRecord::Migration
  def change
    add_column :routes, :minfare, :string
    add_column :routes, :maxfare, :string
    add_column :routes, :distance, :integer

    remove_column :flights, :integer
  end
end
