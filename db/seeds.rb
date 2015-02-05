## AIRPORTS SEED ##
Airport.create(iata:"MLE",citycode:"MLE",name:"Male International Airport",city:"Male",country:"Maldives",population:1000000,slots_total:1989,slots_available:1213,latitude:4.187475,longitude:73.530782,routes:3,flights:19,display:1)
Airport.create(iata:"SIN",citycode:"SIN",name:"Changi International Airport",city:"Singapore",country:"Singapore",population:1000000,slots_total:1989,slots_available:1213,latitude:1.361173,longitude:103.990201,routes:6,flights:19,display:1,display:1)
Airport.create(iata:"DWC",citycode:"DXB",name:"Dubai World Central - Al Maktoum International Airport",city:"Dubai",country:"United Arab Emirates",population:1000000,slots_total:1989,slots_available:1213,latitude:24.892845,longitude:55.162467,routes:3,flights:19,display:1)
Airport.create(iata:"DXB",citycode:"DXB",name:"Dubai Airport",city:"Dubai",country:"United Arab Emirates",population:1000000,slots_total:1989,slots_available:1213,latitude:25.248664,longitude:55.352916,routes:6,flights:19,display:1)
Airport.create(iata:"AUH",citycode:"AUH",name:"Abu Dhabi International Airport",city:"Abu Dhabi",country:"United Arab Emirates",population:1000000,slots_total:1989,slots_available:1213,latitude:24.426912,longitude:54.645974,routes:4,flights:19,display:1)
Airport.create(iata:"KWI",citycode:"KWI",name:"Kuwait International Airport",city:"Kuwait",country:"Kuwait",population:1000000,slots_total:1989,slots_available:1213,latitude:29.240116,longitude:47.971251,routes:2,flights:19,display:1)
Airport.create(iata:"HKG",citycode:"HKG",name:"Hong Kong International Airport",city:"Hong Kong",country:"Hong Kong",population:1000000,slots_total:1989,slots_available:1213,latitude:22.315248,longitude:113.93649,routes:1,flights:19,display:1)
Airport.create(iata:"RAN",citycode:"RAN",name:"La Spreta Airport",city:"Ravenna",country:"Italy",population:1000000,slots_total:1989,slots_available:1213,latitude:44.366667,longitude:12.223333,routes:0,flights:19,display:1)
Airport.create(iata:"YCG",citycode:"YCG",name:"Castlegar Airport",city:"Castlegar",country:"Canada",population:1000000,slots_total:1989,slots_available:1213,latitude:49.295556,longitude:-117.632222,routes:0,flights:19,display:1)
Airport.create(iata:"ROR",citycode:"ROR",name:"Airai Airport",city:"Koror",country:"Palau",population:1000000,slots_total:1989,slots_available:1213,latitude:7.364122,longitude:134.532892,routes:0,flights:19,display:1)
Airport.create(iata:"TIS",citycode:"TIS",name:"Thursday Island Airport",city:"Thursday Island",country:"Australia",population:1000000,slots_total:1989,slots_available:1213,latitude:-10.5,longitude:142.05,routes:0,flights:19,display:1)
Airport.create(iata:"STU",citycode:"STU",name:"Santa Cruz Airport",city:"Santa Cruz",country:"Belize",population:1000000,slots_total:1989,slots_available:1213,latitude:18.266667,longitude:-88.45,routes:0,flights:19,display:1)
Airport.create(iata:"NNI",citycode:"NNI",name:"Namutoni Airport",city:"Namutoni",country:"Namibia",population:1000000,slots_total:1989,slots_available:1213,latitude:-18.816667,longitude:16.916667,routes:0,flights:19,display:1)
Airport.create(iata:"NGO",citycode:"NGO",name:"Chubu Centrair International Airport",city:"Nagoya",country:"Japan",population:1000000,slots_total:1989,slots_available:1213,latitude:34.858333,longitude:136.805278,routes:0,flights:19,display:1)
Airport.create(iata:"LAX",citycode:"LAX",name:"Los Angeles International Airport",city:"Los Angeles",country:"United States",population:1000000,slots_total:1989,slots_available:1213,latitude:33.943399,longitude:-118.408279,routes:0,flights:19,display:1)
Airport.create(iata:"JFK",citycode:"NYC",name:"John F. Kennedy International Airport",city:"New York",country:"United States",population:1000000,slots_total:1989,slots_available:1213,latitude:40.642335,longitude:-73.78817,routes:0,flights:19,display:1)
Airport.create(iata:"EWR",citycode:"EWR",name:"Newark Liberty International Airport",city:"Newark",country:"United States",population:1000000,slots_total:1989,slots_available:1213,latitude:40.689071,longitude:-74.178753,routes:0,flights:19,display:1)
Airport.create(iata:"SFO",citycode:"SFO",name:"San Francisco International Airport",city:"San Francisco",country:"United States",population:1000000,slots_total:1989,slots_available:1213,latitude:37.615215,longitude:-122.389881,routes:0,flights:19,display:1)
Airport.create(iata:"IAD",citycode:"WAS",name:"Washington Dulles International Airport",city:"Washington",country:"United States",population:1000000,slots_total:1989,slots_available:1213,latitude:38.95315,longitude:-77.447735,routes:0,flights:19,display:1)
Airport.create(iata:"IAH",citycode:"HOU",name:"George Bush Intercontinental Airport",city:"Houston",country:"United States",population:1000000,slots_total:1989,slots_available:1213,latitude:29.983333,longitude:-95.34,routes:0,flights:19,display:1)
Airport.create(iata:"ORD",citycode:"CHI",name:"O'Hare International Airport",city:"Chicago",country:"United States",population:1000000,slots_total:1989,slots_available:1213,latitude:41.976912,longitude:-87.904876,routes:0,flights:19,display:1)
Airport.create(iata:"DEN",citycode:"DEN",name:"Denver International Airport",city:"Denver",country:"United States",population:1000000,slots_total:1989,slots_available:1213,latitude:39.851382,longitude:-104.673098,routes:0,flights:19,display:1)

## ROUTES SEED ##
Route.create(origin_id:1,destination_id:1,demand:900,demand_y:670,price_y:500,demand_p:110,price_p:1500,demand_j:110,price_j:3500,demand_f:10,price_f:5000)
Route.create(origin_id:1,destination_id:2,demand:600,demand_y:370,price_y:300,demand_p:110,price_p:1000,demand_j:110,price_j:3000,demand_f:10,price_f:4000)
Route.create(origin_id:1,destination_id:3,demand:700,demand_y:470,price_y:400,demand_p:110,price_p:1100,demand_j:110,price_j:2500,demand_f:10,price_f:4500)
Route.create(origin_id:4,destination_id:5,demand:900,demand_y:670,price_y:500,demand_p:110,price_p:1500,demand_j:110,price_j:3500,demand_f:10,price_f:5000)
Route.create(origin_id:4,destination_id:2,demand:900,demand_y:670,price_y:500,demand_p:110,price_p:1500,demand_j:110,price_j:3500,demand_f:10,price_f:5000)
Route.create(origin_id:2,destination_id:5,demand:900,demand_y:670,price_y:500,demand_p:110,price_p:1500,demand_j:110,price_j:3500,demand_f:10,price_f:5000)
Route.create(origin_id:2,destination_id:3,demand:900,demand_y:670,price_y:500,demand_p:110,price_p:1500,demand_j:110,price_j:3500,demand_f:10,price_f:5000)
Route.create(origin_id:3,destination_id:5,demand:900,demand_y:670,price_y:500,demand_p:110,price_p:1500,demand_j:110,price_j:3500,demand_f:10,price_f:5000)
Route.create(origin_id:4,destination_id:2,demand:900,demand_y:670,price_y:500,demand_p:110,price_p:1500,demand_j:110,price_j:3500,demand_f:10,price_f:5000)
Route.create(origin_id:5,destination_id:4,demand:900,demand_y:670,price_y:500,demand_p:110,price_p:1500,demand_j:110,price_j:3500,demand_f:10,price_f:5000)
Route.create(origin_id:6,destination_id:2,demand:900,demand_y:670,price_y:500,demand_p:110,price_p:1500,demand_j:110,price_j:3500,demand_f:10,price_f:5000)
Route.create(origin_id:7,destination_id:4,demand:900,demand_y:670,price_y:500,demand_p:110,price_p:1500,demand_j:110,price_j:3500,demand_f:10,price_f:5000)
Route.create(origin_id:4,destination_id:6,demand:900,demand_y:670,price_y:500,demand_p:110,price_p:1500,demand_j:110,price_j:3500,demand_f:10,price_f:5000)
Route.create(origin_id:10,destination_id:9,demand:900,demand_y:670,price_y:500,demand_p:110,price_p:1500,demand_j:110,price_j:3500,demand_f:10,price_f:5000)
Route.create(origin_id:9,destination_id:8,demand:900,demand_y:670,price_y:500,demand_p:110,price_p:1500,demand_j:110,price_j:3500,demand_f:10,price_f:5000)
Route.create(origin_id:8,destination_id:11,demand:900,demand_y:670,price_y:500,demand_p:110,price_p:1500,demand_j:110,price_j:3500,demand_f:10,price_f:5000)
Route.create(origin_id:11,destination_id:12,demand:900,demand_y:670,price_y:500,demand_p:110,price_p:1500,demand_j:110,price_j:3500,demand_f:10,price_f:5000)
Route.create(origin_id:12,destination_id:13,demand:900,demand_y:670,price_y:500,demand_p:110,price_p:1500,demand_j:110,price_j:3500,demand_f:10,price_f:5000)
Route.create(origin_id:13,destination_id:14,demand:900,demand_y:670,price_y:500,demand_p:110,price_p:1500,demand_j:110,price_j:3500,demand_f:10,price_f:5000)

## FLIGHTS SEED ##
Flight.create(route_id:1,user_aircraft_id:1,duration:500,loads:'{"y":96,"p":86,"j":88,"f":65}',profit:'{"y":20000,"p":8600,"j":8800,"f":6500}',frequencies:7,fare:'{"y":"500","p":"1000","j":"3300","f":"4600"}',revenue:90000,cost:75000,airline_id:1)
Flight.create(route_id:1,user_aircraft_id:2,duration:100,loads:'{"y":96,"p":86,"j":88,"f":65}',profit:'{"y":20000,"p":8600,"j":8800,"f":6100}',frequencies:21,fare:'{"y":510,"p":1200,"j":3310,"f":4620}',revenue:91000,cost:72000,airline_id:1)
Flight.create(route_id:2,user_aircraft_id:3,duration:510,loads:'{"y":96,"p":86,"j":88,"f":65}',profit:'{"y":20000,"p":8600,"j":8800,"f":6000}',frequencies:5,fare:'{"y":520,"p":1300,"j":3320,"f":4630}',revenue:92000,cost:71000,airline_id:1)
Flight.create(route_id:3,user_aircraft_id:4,duration:520,loads:'{"y":96,"p":86,"j":88,"f":65}',profit:'{"y":20000,"p":8600,"j":8800,"f":5500}',frequencies:14,fare:'{"y":530,"p":1400,"j":3330,"f":4640}',revenue:93000,cost:95000,airline_id:1)
Flight.create(route_id:4,user_aircraft_id:5,duration:250,loads:'{"y":96,"p":86,"j":88,"f":65}',profit:'{"y":20000,"p":8600,"j":8800,"f":5800}',frequencies:5,fare:'{"y":540,"p":1500,"j":3340,"f":4650}',revenue:94000,cost:10000,airline_id:1)
Flight.create(route_id:5,user_aircraft_id:6,duration:540,loads:'{"y":96,"p":86,"j":88,"f":65}',profit:'{"y":20000,"p":8600,"j":8800,"f":5200}',frequencies:4,fare:'{"y":550,"p":1600,"j":3350,"f":4660}',revenue:95000,cost:73000,airline_id:1)
Flight.create(route_id:6,user_aircraft_id:7,duration:550,loads:'{"y":96,"p":86,"j":88,"f":65}',profit:'{"y":20000,"p":8600,"j":8800,"f":5300}',frequencies:2,fare:'{"y":560,"p":1700,"j":3360,"f":4670}',revenue:96000,cost:75600,airline_id:1)
Flight.create(route_id:7,user_aircraft_id:8,duration:560,loads:'{"y":96,"p":86,"j":88,"f":65}',profit:'{"y":20000,"p":8600,"j":8800,"f":5400}',frequencies:12,fare:'{"y":570,"p":1800,"j":3370,"f":4680}',revenue:97000,cost:97000,airline_id:1)
Flight.create(route_id:8,user_aircraft_id:9,duration:570,loads:'{"y":96,"p":86,"j":88,"f":65}',profit:'{"y":20000,"p":8600,"j":8800,"f":7300}',frequencies:20,fare:'{"y":580,"p":1900,"j":3380,"f":4690}',revenue:98000,cost:120000,airline_id:1)
Flight.create(route_id:9,user_aircraft_id:10,duration:540,loads:'{"y":96,"p":86,"j":88,"f":65}',profit:'{"y":20000,"p":8600,"j":8800,"f":5200}',frequencies:4,fare:'{"y":550,"p":1600,"j":3350,"f":4660}',revenue:95000,cost:73000,airline_id:1)
Flight.create(route_id:10,user_aircraft_id:11,duration:550,loads:'{"y":96,"p":86,"j":88,"f":65}',profit:'{"y":20000,"p":8600,"j":8800,"f":5300}',frequencies:2,fare:'{"y":560,"p":1700,"j":3360,"f":4670}',revenue:96000,cost:75600,airline_id:1)
Flight.create(route_id:11,user_aircraft_id:12,duration:560,loads:'{"y":96,"p":86,"j":88,"f":65}',profit:'{"y":20000,"p":8600,"j":8800,"f":5400}',frequencies:12,fare:'{"y":570,"p":1800,"j":3370,"f":4680}',revenue:97000,cost:97000,airline_id:1)
Flight.create(route_id:12,user_aircraft_id:13,duration:570,loads:'{"y":96,"p":86,"j":88,"f":65}',profit:'{"y":20000,"p":8600,"j":8800,"f":7300}',frequencies:20,fare:'{"y":580,"p":1900,"j":3380,"f":4690}',revenue:98000,cost:120000,airline_id:1)
Flight.create(route_id:6,user_aircraft_id:14,duration:550,loads:'{"y":96,"p":86,"j":88,"f":65}',profit:'{"y":20000,"p":8600,"j":8800,"f":5300}',frequencies:2,fare:'{"y":560,"p":1700,"j":3360,"f":4670}',revenue:96000,cost:75600,airline_id:1)
Flight.create(route_id:7,user_aircraft_id:15,duration:560,loads:'{"y":96,"p":86,"j":88,"f":65}',profit:'{"y":20000,"p":8600,"j":8800,"f":5400}',frequencies:12,fare:'{"y":570,"p":1800,"j":3370,"f":4680}',revenue:97000,cost:97000,airline_id:1)
Flight.create(route_id:8,user_aircraft_id:16,duration:570,loads:'{"y":96,"p":86,"j":88,"f":65}',profit:'{"y":20000,"p":8600,"j":8800,"f":7300}',frequencies:20,fare:'{"y":580,"p":1900,"j":3380,"f":4690}',revenue:98000,cost:120000,airline_id:1)
Flight.create(route_id:14,user_aircraft_id:17,duration:570,loads:'{"y":96,"p":86,"j":88,"f":65}',profit:'{"y":20000,"p":8600,"j":8800,"f":7300}',frequencies:20,fare:'{"y":580,"p":1900,"j":3380,"f":4690}',revenue:98000,cost:120000,airline_id:1)
Flight.create(route_id:15,user_aircraft_id:18,duration:540,loads:'{"y":96,"p":86,"j":88,"f":65}',profit:'{"y":20000,"p":8600,"j":8800,"f":5200}',frequencies:4,fare:'{"y":550,"p":1600,"j":3350,"f":4660}',revenue:95000,cost:73000,airline_id:1)
Flight.create(route_id:16,user_aircraft_id:19,duration:550,loads:'{"y":96,"p":86,"j":88,"f":65}',profit:'{"y":20000,"p":8600,"j":8800,"f":5300}',frequencies:2,fare:'{"y":560,"p":1700,"j":3360,"f":4670}',revenue:96000,cost:75600,airline_id:1)
Flight.create(route_id:17,user_aircraft_id:20,duration:560,loads:'{"y":96,"p":86,"j":88,"f":65}',profit:'{"y":20000,"p":8600,"j":8800,"f":5400}',frequencies:12,fare:'{"y":570,"p":1800,"j":3370,"f":4680}',revenue:97000,cost:97000,airline_id:1)
Flight.create(route_id:18,user_aircraft_id:21,duration:570,loads:'{"y":96,"p":86,"j":88,"f":65}',profit:'{"y":20000,"p":8600,"j":8800,"f":7300}',frequencies:20,fare:'{"y":580,"p":1900,"j":3380,"f":4690}',revenue:98000,cost:120000,airline_id:1)
Flight.create(route_id:19,user_aircraft_id:22,duration:550,loads:'{"y":96,"p":86,"j":88,"f":65}',profit:'{"y":20000,"p":8600,"j":8800,"f":5300}',frequencies:2,fare:'{"y":560,"p":1700,"j":3360,"f":4670}',revenue:96000,cost:75600,airline_id:1)
Flight.create(route_id:7,user_aircraft_id:23,duration:560,loads:'{"y":96,"p":86,"j":88,"f":65}',profit:'{"y":20000,"p":8600,"j":8800,"f":5400}',frequencies:12,fare:'{"y":570,"p":1800,"j":3370,"f":4680}',revenue:97000,cost:97000,airline_id:1)
Flight.create(route_id:9,user_aircraft_id:24,duration:570,loads:'{"y":96,"p":86,"j":88,"f":65}',profit:'{"y":20000,"p":8600,"j":8800,"f":7300}',frequencies:20,fare:'{"y":580,"p":1900,"j":3380,"f":4690}',revenue:98000,cost:120000,airline_id:1)
Flight.create(route_id:17,user_aircraft_id:30,duration:560,loads:'{"y":96,"p":86,"j":88,"f":65}',profit:'{"y":20000,"p":8600,"j":8800,"f":5400}',frequencies:12,fare:'{"y":570,"p":1800,"j":3370,"f":4680}',revenue:97000,cost:97000,airline_id:2)
Flight.create(route_id:18,user_aircraft_id:31,duration:570,loads:'{"y":96,"p":86,"j":88,"f":65}',profit:'{"y":20000,"p":8600,"j":8800,"f":7300}',frequencies:20,fare:'{"y":580,"p":1900,"j":3380,"f":4690}',revenue:98000,cost:120000,airline_id:2)
Flight.create(route_id:19,user_aircraft_id:32,duration:550,loads:'{"y":96,"p":86,"j":88,"f":65}',profit:'{"y":20000,"p":8600,"j":8800,"f":5300}',frequencies:2,fare:'{"y":560,"p":1700,"j":3360,"f":4670}',revenue:96000,cost:75600,airline_id:2)
Flight.create(route_id:7,user_aircraft_id:33,duration:560,loads:'{"y":96,"p":86,"j":88,"f":65}',profit:'{"y":20000,"p":8600,"j":8800,"f":5400}',frequencies:12,fare:'{"y":570,"p":1800,"j":3370,"f":4680}',revenue:97000,cost:97000,airline_id:2)
Flight.create(route_id:9,user_aircraft_id:34,duration:570,loads:'{"y":96,"p":86,"j":88,"f":65}',profit:'{"y":20000,"p":8600,"j":8800,"f":7300}',frequencies:20,fare:'{"y":580,"p":1900,"j":3380,"f":4690}',revenue:98000,cost:120000,airline_id:2)

## AIRCRAFT SEED ##
Aircraft.create(name:"737-700",manufacturer:"Boeing",iata:"73G",capacity:149,speed:514,turn_time:35,price:78300000,discount:2,fuel_capacity:6875,range:3950,sqft:671)
Aircraft.create(name:"737-800",manufacturer:"Boeing",iata:"738",capacity:189,speed:514,turn_time:40,price:93300000,discount:2,fuel_capacity:6875,range:3400,sqft:851)
Aircraft.create(name:"737-900ER",manufacturer:"Boeing",iata:"739",capacity:220,speed:511,turn_time:45,price:99000000,discount:2,fuel_capacity:7837,range:3520,sqft:990)
Aircraft.create(name:"747-400",manufacturer:"Boeing",iata:"744",capacity:565,speed:567,turn_time:90,price:250000000,discount:2,fuel_capacity:57285,range:8350,sqft:2543)
Aircraft.create(name:"747-8i",manufacturer:"Boeing",iata:"748",capacity:605,speed:570,turn_time:90,price:350000000,discount:2,fuel_capacity:64225,range:9200,sqft:2723)
Aircraft.create(name:"757-200",manufacturer:"Boeing",iata:"752",capacity:239,speed:530,turn_time:50,price:65000000,discount:2,fuel_capacity:11500,range:4700,sqft:1076)
Aircraft.create(name:"757-300",manufacturer:"Boeing",iata:"753",capacity:295,speed:530,turn_time:60,price:80000000,discount:2,fuel_capacity:11500,range:4150,sqft:1328)
Aircraft.create(name:"767-200ER",manufacturer:"Boeing",iata:"762",capacity:290,speed:530,turn_time:60,price:160000000,discount:2,fuel_capacity:24140,range:7350,sqft:1305)
Aircraft.create(name:"767-300ER",manufacturer:"Boeing",iata:"763",capacity:350,speed:530,turn_time:70,price:185000000,discount:2,fuel_capacity:24140,range:7260,sqft:1575)
Aircraft.create(name:"767-400",manufacturer:"Boeing",iata:"764",capacity:375,speed:530,turn_time:70,price:200000000,discount:2,fuel_capacity:24140,range:6450,sqft:1688)
Aircraft.create(name:"777-200ER",manufacturer:"Boeing",iata:"77E",capacity:440,speed:550,turn_time:90,price:261000000,discount:2,fuel_capacity:45250,range:8900,sqft:1980)
Aircraft.create(name:"777-200LR",manufacturer:"Boeing",iata:"77L",capacity:440,speed:550,turn_time:90,price:296000000,discount:2,fuel_capacity:47900,range:10800,sqft:1980)
Aircraft.create(name:"777-300ER",manufacturer:"Boeing",iata:"77W",capacity:550,speed:550,turn_time:90,price:320000000,discount:2,fuel_capacity:47900,range:9100,sqft:2475)
Aircraft.create(name:"787-8",manufacturer:"Boeing",iata:"788",capacity:380,speed:567,turn_time:90,price:218000000,discount:2,fuel_capacity:33340,range:9030,sqft:1710)
Aircraft.create(name:"787-9",manufacturer:"Boeing",iata:"789",capacity:420,speed:567,turn_time:90,price:257000000,discount:2,fuel_capacity:36640,range:9550,sqft:1890)
Aircraft.create(name:"787-10",manufacturer:"Boeing",iata:"780",capacity:460,speed:567,turn_time:90,price:297000000,discount:2,fuel_capacity:36640,range:8080,sqft:2070)
Aircraft.create(name:"A318",manufacturer:"Airbus",iata:"318",capacity:132,speed:511,turn_time:30,price:72000000,discount:2,fuel_capacity:6400,range:3700,sqft:594)
Aircraft.create(name:"A319",manufacturer:"Airbus",iata:"319",capacity:156,speed:511,turn_time:35,price:86000000,discount:2,fuel_capacity:6400,range:4300,sqft:702)
Aircraft.create(name:"A320",manufacturer:"Airbus",iata:"320",capacity:180,speed:511,turn_time:40,price:94000000,discount:2,fuel_capacity:6400,range:3800,sqft:810)
Aircraft.create(name:"A321",manufacturer:"Airbus",iata:"321",capacity:220,speed:511,turn_time:45,price:110000000,discount:2,fuel_capacity:6350,range:3700,sqft:990)
Aircraft.create(name:"A330-200",manufacturer:"Airbus",iata:"332",capacity:375,speed:541,turn_time:75,price:222000000,discount:2,fuel_capacity:36740,range:8285,sqft:1688)
Aircraft.create(name:"A330-300",manufacturer:"Airbus",iata:"333",capacity:410,speed:541,turn_time:75,price:246000000,discount:2,fuel_capacity:25760,range:7020,sqft:1845)
Aircraft.create(name:"A340-300",manufacturer:"Airbus",iata:"343",capacity:400,speed:567,turn_time:90,price:238000000,discount:2,fuel_capacity:39060,range:8500,sqft:1800)
Aircraft.create(name:"A340-500",manufacturer:"Airbus",iata:"345",capacity:420,speed:567,turn_time:90,price:262000000,discount:2,fuel_capacity:56750,range:9980,sqft:1890)
Aircraft.create(name:"A340-600",manufacturer:"Airbus",iata:"346",capacity:440,speed:567,turn_time:90,price:275000000,discount:2,fuel_capacity:51750,range:8920,sqft:1980)
Aircraft.create(name:"A350-800",manufacturer:"Airbus",iata:"358",capacity:400,speed:561,turn_time:90,price:261000000,discount:2,fuel_capacity:34100,range:9250,sqft:1800)
Aircraft.create(name:"A350-900",manufacturer:"Airbus",iata:"359",capacity:440,speed:561,turn_time:90,price:295000000,discount:2,fuel_capacity:36500,range:9000,sqft:1980)
Aircraft.create(name:"A350-1000",manufacturer:"Airbus",iata:"35X",capacity:475,speed:561,turn_time:100,price:340000000,discount:2,fuel_capacity:41200,range:9500,sqft:2138)
Aircraft.create(name:"A380-800",manufacturer:"Airbus",iata:"388",capacity:850,speed:560,turn_time:100,price:400000000,discount:2,fuel_capacity:85472,range:9755,sqft:3825)
Aircraft.create(name:"CRJ200ER",manufacturer:"Bombardier",iata:"CR2",capacity:50,speed:488,turn_time:30,price:25000000,discount:2,fuel_capacity:1700,range:1895,sqft:225)
Aircraft.create(name:"CRJ700",manufacturer:"Bombardier",iata:"CR7",capacity:78,speed:515,turn_time:30,price:30000000,discount:2,fuel_capacity:2400,range:1400,sqft:351)
Aircraft.create(name:"CRJ900",manufacturer:"Bombardier",iata:"CR9",capacity:90,speed:528,turn_time:30,price:35000000,discount:2,fuel_capacity:2900,range:1200,sqft:405)
Aircraft.create(name:"CRJ1000",manufacturer:"Bombardier",iata:"CR1",capacity:104,speed:515,turn_time:30,price:40000000,discount:2,fuel_capacity:2900,range:1640,sqft:468)
Aircraft.create(name:"ERJ 145XR",manufacturer:"Embraer",iata:"E4X",capacity:50,speed:500,turn_time:30,price:18000000,discount:2,fuel_capacity:1600,range:2900,sqft:225)
Aircraft.create(name:"E170",manufacturer:"Embraer",iata:"E70",capacity:80,speed:550,turn_time:30,price:28500000,discount:2,fuel_capacity:2500,range:2070,sqft:360)
Aircraft.create(name:"E175",manufacturer:"Embraer",iata:"E75",capacity:88,speed:550,turn_time:30,price:34000000,discount:2,fuel_capacity:2500,range:2070,sqft:396)
Aircraft.create(name:"E190",manufacturer:"Embraer",iata:"E90",capacity:114,speed:550,turn_time:30,price:41000000,discount:2,fuel_capacity:3400,range:2070,sqft:513)
Aircraft.create(name:"E195",manufacturer:"Embraer",iata:"E95",capacity:122,speed:550,turn_time:30,price:47000000,discount:2,fuel_capacity:3400,range:1600,sqft:549)

## SEATS SEED ##
Seat.create(service_class:"y",name:"Economy",cost:500,rating:7,sqft:4.5)
Seat.create(service_class:"p",name:"Premium Economy",cost:1000,rating:9,sqft:7)
Seat.create(service_class:"p",name:"Economy Plus",cost:700,rating:7,sqft:5)
Seat.create(service_class:"j",name:"Recliner",cost:5000,rating:7,sqft:11)
Seat.create(service_class:"j",name:"Basic Lie Flat",cost:7000,rating:9,sqft:12)
Seat.create(service_class:"j",name:"Herringbone",cost:10000,rating:10,sqft:14)
Seat.create(service_class:"f",name:"Lie Flat",cost:25000,rating:7,sqft:24)
Seat.create(service_class:"f",name:"Open Suite",cost:40000,rating:9,sqft:30)
Seat.create(service_class:"f",name:"Enclosed Suite",cost:50000,rating:10,sqft:30)

## USER AIRCRAFT SEED ##
UserAircraft.create(airline_id:1,aircraft_id:1,age:1,aircraft_config:'{"y":{"seats":300,"seat_id":1},"p":{"seats":70,"seat_id":2},"j":{"seats":80,"seat_id":6},"f":{"seats":10,"seat_id":9}}',inuse:1)
UserAircraft.create(airline_id:1,aircraft_id:1,age:1,aircraft_config:'{"y":{"seats":300,"seat_id":1},"p":{"seats":90,"seat_id":2},"j":{"seats":110,"seat_id":6},"f":{"seats":0,"seat_id":9}}',inuse:1)
UserAircraft.create(airline_id:1,aircraft_id:2,age:1,aircraft_config:'{"y":{"seats":220,"seat_id":1},"p":{"seats":50,"seat_id":2},"j":{"seats":60,"seat_id":6},"f":{"seats":8,"seat_id":9}}',inuse:1)
UserAircraft.create(airline_id:1,aircraft_id:3,age:1,aircraft_config:'{"y":{"seats":120,"seat_id":1},"p":{"seats":60,"seat_id":3},"j":{"seats":30,"seat_id":5},"f":{"seats":10,"seat_id":7}}',inuse:1)
UserAircraft.create(airline_id:1,aircraft_id:4,age:1,aircraft_config:'{"y":{"seats":300,"seat_id":1},"p":{"seats":70,"seat_id":2},"j":{"seats":80,"seat_id":4},"f":{"seats":10,"seat_id":8}}',inuse:1)
UserAircraft.create(airline_id:1,aircraft_id:5,age:1,aircraft_config:'{"y":{"seats":300,"seat_id":1},"p":{"seats":70,"seat_id":2},"j":{"seats":80,"seat_id":4},"f":{"seats":10,"seat_id":8}}',inuse:1)
UserAircraft.create(airline_id:1,aircraft_id:1,age:1,aircraft_config:'{"y":{"seats":300,"seat_id":1},"p":{"seats":70,"seat_id":2},"j":{"seats":80,"seat_id":6},"f":{"seats":10,"seat_id":9}}',inuse:1)
UserAircraft.create(airline_id:1,aircraft_id:1,age:1,aircraft_config:'{"y":{"seats":300,"seat_id":1},"p":{"seats":90,"seat_id":2},"j":{"seats":110,"seat_id":6},"f":{"seats":0,"seat_id":9}}',inuse:1)
UserAircraft.create(airline_id:1,aircraft_id:2,age:1,aircraft_config:'{"y":{"seats":220,"seat_id":1},"p":{"seats":50,"seat_id":2},"j":{"seats":60,"seat_id":6},"f":{"seats":8,"seat_id":9}}',inuse:1)
UserAircraft.create(airline_id:1,aircraft_id:3,age:1,aircraft_config:'{"y":{"seats":120,"seat_id":1},"p":{"seats":60,"seat_id":3},"j":{"seats":30,"seat_id":5},"f":{"seats":10,"seat_id":7}}',inuse:1)
UserAircraft.create(airline_id:1,aircraft_id:4,age:1,aircraft_config:'{"y":{"seats":300,"seat_id":1},"p":{"seats":70,"seat_id":2},"j":{"seats":80,"seat_id":4},"f":{"seats":10,"seat_id":8}}',inuse:1)
UserAircraft.create(airline_id:1,aircraft_id:5,age:1,aircraft_config:'{"y":{"seats":300,"seat_id":1},"p":{"seats":70,"seat_id":2},"j":{"seats":80,"seat_id":4},"f":{"seats":10,"seat_id":8}}',inuse:1)
UserAircraft.create(airline_id:1,aircraft_id:3,age:1,aircraft_config:'{"y":{"seats":120,"seat_id":1},"p":{"seats":60,"seat_id":3},"j":{"seats":30,"seat_id":5},"f":{"seats":10,"seat_id":7}}',inuse:1)
UserAircraft.create(airline_id:1,aircraft_id:4,age:1,aircraft_config:'{"y":{"seats":300,"seat_id":1},"p":{"seats":70,"seat_id":2},"j":{"seats":80,"seat_id":4},"f":{"seats":10,"seat_id":8}}',inuse:1)
UserAircraft.create(airline_id:1,aircraft_id:5,age:1,aircraft_config:'{"y":{"seats":300,"seat_id":1},"p":{"seats":70,"seat_id":2},"j":{"seats":80,"seat_id":4},"f":{"seats":10,"seat_id":8}}',inuse:1)
UserAircraft.create(airline_id:1,aircraft_id:1,age:1,aircraft_config:'{"y":{"seats":300,"seat_id":1},"p":{"seats":70,"seat_id":2},"j":{"seats":80,"seat_id":6},"f":{"seats":10,"seat_id":9}}',inuse:1)
UserAircraft.create(airline_id:1,aircraft_id:1,age:1,aircraft_config:'{"y":{"seats":300,"seat_id":1},"p":{"seats":90,"seat_id":2},"j":{"seats":110,"seat_id":6},"f":{"seats":0,"seat_id":9}}',inuse:1)
UserAircraft.create(airline_id:1,aircraft_id:2,age:1,aircraft_config:'{"y":{"seats":220,"seat_id":1},"p":{"seats":50,"seat_id":2},"j":{"seats":60,"seat_id":6},"f":{"seats":8,"seat_id":9}}',inuse:1)
UserAircraft.create(airline_id:1,aircraft_id:3,age:1,aircraft_config:'{"y":{"seats":120,"seat_id":1},"p":{"seats":60,"seat_id":3},"j":{"seats":30,"seat_id":5},"f":{"seats":10,"seat_id":7}}',inuse:1)
UserAircraft.create(airline_id:1,aircraft_id:4,age:1,aircraft_config:'{"y":{"seats":300,"seat_id":1},"p":{"seats":70,"seat_id":2},"j":{"seats":80,"seat_id":4},"f":{"seats":10,"seat_id":8}}',inuse:1)
UserAircraft.create(airline_id:1,aircraft_id:5,age:1,aircraft_config:'{"y":{"seats":300,"seat_id":1},"p":{"seats":70,"seat_id":2},"j":{"seats":80,"seat_id":4},"f":{"seats":10,"seat_id":8}}',inuse:1)
UserAircraft.create(airline_id:1,aircraft_id:1,age:1,aircraft_config:'{"y":{"seats":300,"seat_id":1},"p":{"seats":70,"seat_id":2},"j":{"seats":80,"seat_id":6},"f":{"seats":10,"seat_id":9}}',inuse:1)
UserAircraft.create(airline_id:1,aircraft_id:1,age:1,aircraft_config:'{"y":{"seats":300,"seat_id":1},"p":{"seats":90,"seat_id":2},"j":{"seats":110,"seat_id":6},"f":{"seats":0,"seat_id":9}}',inuse:1)
UserAircraft.create(airline_id:1,aircraft_id:2,age:1,aircraft_config:'{"y":{"seats":220,"seat_id":1},"p":{"seats":50,"seat_id":2},"j":{"seats":60,"seat_id":6},"f":{"seats":8,"seat_id":9}}',inuse:1)
UserAircraft.create(airline_id:1,aircraft_id:1,age:1,aircraft_config:'{"y":{"seats":300,"seat_id":1},"p":{"seats":70,"seat_id":2},"j":{"seats":80,"seat_id":6},"f":{"seats":10,"seat_id":9}}',inuse:0)
UserAircraft.create(airline_id:1,aircraft_id:1,age:1,aircraft_config:'{"y":{"seats":300,"seat_id":1},"p":{"seats":90,"seat_id":2},"j":{"seats":110,"seat_id":6},"f":{"seats":0,"seat_id":9}}',inuse:0)
UserAircraft.create(airline_id:1,aircraft_id:2,age:1,aircraft_config:'{"y":{"seats":220,"seat_id":1},"p":{"seats":50,"seat_id":2},"j":{"seats":60,"seat_id":6},"f":{"seats":8,"seat_id":9}}',inuse:0)
UserAircraft.create(airline_id:1,aircraft_id:1,age:1,aircraft_config:'{"y":{"seats":300,"seat_id":1},"p":{"seats":70,"seat_id":2},"j":{"seats":80,"seat_id":6},"f":{"seats":10,"seat_id":9}}',inuse:0)
UserAircraft.create(airline_id:1,aircraft_id:2,age:1,aircraft_config:'{"y":{"seats":300,"seat_id":1},"p":{"seats":90,"seat_id":2},"j":{"seats":110,"seat_id":6},"f":{"seats":0,"seat_id":9}}',inuse:0)
UserAircraft.create(airline_id:2,aircraft_id:2,age:1,aircraft_config:'{"y":{"seats":220,"seat_id":1},"p":{"seats":50,"seat_id":2},"j":{"seats":60,"seat_id":6},"f":{"seats":8,"seat_id":9}}',inuse:0)
UserAircraft.create(airline_id:2,aircraft_id:3,age:1,aircraft_config:'{"y":{"seats":120,"seat_id":1},"p":{"seats":60,"seat_id":3},"j":{"seats":30,"seat_id":5},"f":{"seats":10,"seat_id":7}}',inuse:1)
UserAircraft.create(airline_id:2,aircraft_id:1,age:1,aircraft_config:'{"y":{"seats":300,"seat_id":1},"p":{"seats":70,"seat_id":2},"j":{"seats":80,"seat_id":4},"f":{"seats":10,"seat_id":8}}',inuse:1)
UserAircraft.create(airline_id:2,aircraft_id:2,age:1,aircraft_config:'{"y":{"seats":300,"seat_id":1},"p":{"seats":70,"seat_id":2},"j":{"seats":80,"seat_id":4},"f":{"seats":10,"seat_id":8}}',inuse:1)
UserAircraft.create(airline_id:2,aircraft_id:3,age:1,aircraft_config:'{"y":{"seats":300,"seat_id":1},"p":{"seats":70,"seat_id":2},"j":{"seats":80,"seat_id":4},"f":{"seats":10,"seat_id":8}}',inuse:1)
UserAircraft.create(airline_id:2,aircraft_id:4,age:1,aircraft_config:'{"y":{"seats":300,"seat_id":1},"p":{"seats":70,"seat_id":2},"j":{"seats":80,"seat_id":4},"f":{"seats":10,"seat_id":8}}',inuse:1)
UserAircraft.create(airline_id:2,aircraft_id:5,age:1,aircraft_config:'{"y":{"seats":300,"seat_id":1},"p":{"seats":70,"seat_id":2},"j":{"seats":80,"seat_id":4},"f":{"seats":10,"seat_id":8}}',inuse:0)
UserAircraft.create(airline_id:2,aircraft_id:1,age:1,aircraft_config:'{"y":{"seats":300,"seat_id":1},"p":{"seats":70,"seat_id":2},"j":{"seats":80,"seat_id":6},"f":{"seats":10,"seat_id":9}}',inuse:0)

# USER SEED ##
User.create(username:"kziel",password:"kziel")
User.create(username:"cam_i",password:"cam_i")
User.create(username:"roryg",password:"roryg")
User.create(username:"danam",password:"danam")
User.create(username:"smycal",password:"smycal")

# GAME SEED ##
Game.create(year:2015,month:2,region:"all")

# AIRLINE SEED ##
Airline.create(name:"INnoVation Airlines",iata:"IAL",hub:"ICN",game_id:1,user_id:1)
Airline.create(name:"SKT Air",iata:"SKT",hub:"BUS",game_id:1,user_id:2)
Airline.create(name:"Velocity Air Germany",iata:"VLG",hub:"FRA",game_id:1,user_id:3)
Airline.create(name:"Velocity Air Georgia",iata:"VLX",hub:"CDG",game_id:1,user_id:4)
Airline.create(name:"Velocity Air Austria",iata:"VLA",hub:"VIE",game_id:1,user_id:5)

# ActiveRecord::Base.connection.execute("DELETE from sqlite_sequence where name = '<table_name>'")
['DXB','AUH','SIN','KWI','BAH','DOH','KUL','SYD','GLA','MEL','PER','HKG','MFM','ICN','NRT','ROR','YCG','RAN','TIS','STU','NNI','NGO','PEK','PVG','HNL','KOA','OGG','LIH','AKL','GUM','ANC','SEA','PDX','SMF','SFO','SJC','LAX','SAN','PHX','LAS','MEX','GRU','GIG','SCL','EZE','PTY','IAH','DFW','ABQ','RNO','DEN','ORD','YVR','YYC','ZRH','YOW','YYT','BOS','JFK','EWR','IAD','RDU','CLT','MIA','MCO','FLL','MSY','OMA','DTW','MSP','CLE','MEM','BOI','OKC','BZN','FAR','TIJ','PVR','CUN','EDI','SNN','LHR','MAN','CDG','FRA','MUC','TXL','VIE','IST','CAI','TLV','DME','COS','CGK','MLE','DOM','DEL','BKK','FUK','KIX','GUM','FCO','BCN','MXP','TPE','TBS','AMS','BRU','GVA']
