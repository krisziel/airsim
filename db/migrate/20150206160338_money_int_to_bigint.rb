class MoneyIntToBigint < ActiveRecord::Migration
  def change
    change_column :airlines, :money, 'bigint USING CAST(money AS bigint)'
  end
end
