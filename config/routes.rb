Rails.application.routes.draw do

  root 'app#index'

  ## AIRPORTS ##
  get 'airports/scrape/:country' => 'airports#scrape'
  get 'airports/' => 'airports#all'
  get 'airports/seed' => 'airports#seed'
  get 'airports/population' => 'airports#population'
  get 'airports/reseed' => 'airports#reseed'
  get 'airports/:iata' => 'airports#data'
  patch 'airports/:iata/' => 'airports#update'

  ## ROUTES ##
  get 'routes/' => 'routes#all'
  get 'routes/distance' => 'routes#distance'
  get 'route/parse_demand' => 'routes#parse_demand'
  get 'route/competitors' => 'routes#competitors'
  get 'routes/generate' => 'routes#generate_routes'
  get 'routes/:id' => 'routes#info'
  get 'routes/:origin/:destination' => 'routes#info'

  ## FLIGHTS ##
  get 'flights/' => 'flights#all'
  post 'flights/new' => 'flights#create'
  post 'flights/update' => 'flights#update'
  get 'flights/:id' => 'flights#info'
  get 'flights/:origin/:destination' => 'flights#info'

  ## AIRCRAFT ##
  get 'aircrafts/' => 'aircrafts#all'
  get 'aircrafts/airline' => 'aircrafts#airline'
  post 'aircrafts/buy' => 'aircrafts#buy'
  get 'aircrafts/buy' => 'aircrafts#buy'
  post 'aircrafts/update' => 'aircrafts#update'
  get 'aircrafts/:id' => 'flights#info'

  ## SEATS ##
  get 'seats/' => 'seats#all'

  ## TURN ##
  get 'demand/turn' => 'demand#turn'

end
