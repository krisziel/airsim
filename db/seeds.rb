# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

## ROUTES SEED ##
Route.create(origin_id:1,destination_id:25,demand:900,demand_y:670,price_y:500,demand_p:110,price_p:1500,demand_j:110,price_j:3500,demand_f:10,price_f:5000)
Route.create(origin_id:1,destination_id:4,demand:600,demand_y:370,price_y:300,demand_p:110,price_p:1000,demand_j:110,price_j:3000,demand_f:10,price_f:4000)
Route.create(origin_id:1,destination_id:30,demand:700,demand_y:470,price_y:400,demand_p:110,price_p:1100,demand_j:110,price_j:2500,demand_f:10,price_f:4500)
Route.create(origin_id:4,destination_id:25,demand:900,demand_y:670,price_y:500,demand_p:110,price_p:1500,demand_j:110,price_j:3500,demand_f:10,price_f:5000)
Route.create(origin_id:4,destination_id:2,demand:900,demand_y:670,price_y:500,demand_p:110,price_p:1500,demand_j:110,price_j:3500,demand_f:10,price_f:5000)
Route.create(origin_id:2,destination_id:30,demand:900,demand_y:670,price_y:500,demand_p:110,price_p:1500,demand_j:110,price_j:3500,demand_f:10,price_f:5000)
Route.create(origin_id:2,destination_id:25,demand:900,demand_y:670,price_y:500,demand_p:110,price_p:1500,demand_j:110,price_j:3500,demand_f:10,price_f:5000)
Route.create(origin_id:30,destination_id:25,demand:900,demand_y:670,price_y:500,demand_p:110,price_p:1500,demand_j:110,price_j:3500,demand_f:10,price_f:5000)

## FLIGHTS SEED ##
Flight.create(route_id:1,user_aircraft_id:1,duration:500,amenities:'{"idk":"idk"}',frequencies:7,fare:'{"y":"500","p":"1000","j":"3300","f":"4600"}',revenue:90000,cost:75000,user_id:1,aircraft_id:1)
Flight.create(route_id:1,user_aircraft_id:2,duration:490,amenities:'{"idk":"idk"}',frequencies:21,fare:'{"y":"510","p":"1200","j":"3310","f":"4620"}',revenue:91000,cost:72000,user_id:1,aircraft_id:2)
Flight.create(route_id:2,user_aircraft_id:3,duration:510,amenities:'{"idk":"idk"}',frequencies:5,fare:'{"y":"520","p":"1300","j":"3320","f":"4630"}',revenue:92000,cost:71000,user_id:1,aircraft_id:3)
Flight.create(route_id:3,user_aircraft_id:4,duration:520,amenities:'{"idk":"idk"}',frequencies:14,fare:'{"y":"530","p":"1400","j":"3330","f":"4640"}',revenue:93000,cost:95000,user_id:1,aircraft_id:1)
Flight.create(route_id:4,user_aircraft_id:5,duration:530,amenities:'{"idk":"idk"}',frequencies:5,fare:'{"y":"540","p":"1500","j":"3340","f":"4650"}',revenue:94000,cost:10000,user_id:1,aircraft_id:1)
Flight.create(route_id:5,user_aircraft_id:6,duration:540,amenities:'{"idk":"idk"}',frequencies:4,fare:'{"y":"550","p":"1600","j":"3350","f":"4660"}',revenue:95000,cost:73000,user_id:1,aircraft_id:4)
Flight.create(route_id:6,user_aircraft_id:7,duration:550,amenities:'{"idk":"idk"}',frequencies:2,fare:'{"y":"560","p":"1700","j":"3360","f":"4670"}',revenue:96000,cost:75600,user_id:1,aircraft_id:2)
Flight.create(route_id:7,user_aircraft_id:8,duration:560,amenities:'{"idk":"idk"}',frequencies:12,fare:'{"y":"570","p":"1800","j":"3370","f":"4680"}',revenue:97000,cost:97000,user_id:1,aircraft_id:3)
Flight.create(route_id:8,user_aircraft_id:9,duration:570,amenities:'{"idk":"idk"}',frequencies:20,fare:'{"y":"580","p":"1900","j":"3380","f":"4690"}',revenue:98000,cost:120000,user_id:1,aircraft_id:1)

## AIRCRAFT SEED ##
Aircraft.create(name:"777-300ER",manufacturer:"Boeing",iata:"77W",capacity:550,speed:550,turn_time:90,price:300000000,discount:2,fuel_capacity:55000,range:9500)
Aircraft.create(name:"A380",manufacturer:"Airbus",iata:"380",capacity:850,speed:550,turn_time:120,price:400000000,discount:2,fuel_capacity:85000,range:9500)
Aircraft.create(name:"767-300",manufacturer:"Boeing",iata:"763",capacity:350,speed:550,turn_time:70,price:180000000,discount:2,fuel_capacity:25000,range:6000)
Aircraft.create(name:"A350-900",manufacturer:"Airbus",iata:"359",capacity:450,speed:550,turn_time:80,price:290000000,discount:2,fuel_capacity:40000,range:9500)
