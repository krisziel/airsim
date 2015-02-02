# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150202182738) do

  create_table "aircraft_capacities", force: true do |t|
    t.integer "aircraft_id"
    t.integer "capacity"
    t.integer "class_config"
  end

  create_table "aircrafts", force: true do |t|
    t.string  "name"
    t.string  "manufacturer"
    t.string  "iata"
    t.integer "capacity"
    t.integer "speed"
    t.integer "turn_time"
    t.integer "price"
    t.integer "discount"
    t.integer "fuel_capacity"
    t.integer "fuel_burn"
    t.integer "range"
    t.integer "cargo"
    t.integer "sqft"
  end

  create_table "airports", force: true do |t|
    t.string  "iata"
    t.string  "icao"
    t.string  "citycode"
    t.string  "name"
    t.string  "city"
    t.string  "state"
    t.string  "country"
    t.integer "population"
    t.integer "slots_total"
    t.integer "slots_available"
    t.string  "latitude"
    t.string  "longitude"
    t.integer "business_demand"
    t.integer "leisure_demand"
    t.string  "region_name"
    t.string  "country_code"
    t.integer "display"
  end

  create_table "class_types", force: true do |t|
    t.string "name"
    t.string "description"
    t.string "type"
    t.float  "ratio"
    t.float  "premium"
    t.float  "cost"
  end

  create_table "fares", force: true do |t|
    t.integer  "origin_id"
    t.integer  "destination_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "flights", force: true do |t|
    t.integer "route_id"
    t.string  "user_aircraft_id"
    t.integer "duration"
    t.string  "amenities"
    t.integer "frequencies"
    t.string  "fare"
    t.integer "rating"
    t.integer "distance"
    t.integer "passengers"
    t.integer "integer"
    t.integer "revenue"
    t.integer "cost"
    t.integer "user_id"
    t.integer "game_id"
    t.integer "aircraft_id"
    t.string  "loads"
    t.string  "profit"
  end

  create_table "routes", force: true do |t|
    t.integer "origin_id"
    t.integer "destination_id"
    t.integer "demand"
    t.integer "demand_y"
    t.integer "price_y"
    t.integer "demand_p"
    t.integer "price_p"
    t.integer "demand_j"
    t.integer "price_j"
    t.integer "demand_f"
    t.integer "price_f"
    t.float   "y_elasticity"
    t.float   "j_elasticity"
    t.float   "f_elasticity"
    t.float   "p_elasticity"
  end

  create_table "seats", force: true do |t|
    t.string   "class"
    t.string   "name"
    t.integer  "cost"
    t.integer  "rating"
    t.integer  "sqft"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_aircrafts", force: true do |t|
    t.integer "user_id"
    t.integer "aircraft_id"
    t.integer "age"
    t.integer "seats_y"
    t.integer "seats_p"
    t.integer "seats_j"
    t.integer "seats_f"
    t.string  "aircraft_config"
  end

  create_table "users", force: true do |t|
    t.string "username"
    t.string "password_digest"
  end

end
