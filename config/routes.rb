Rails.application.routes.draw do

  root 'app#index'

  ## AIRPORTS ##
  get 'airports/scrape/:country' => 'airports#scrape'
  get 'airports/' => 'airports#all'
  get 'airports/:iata' => 'airports#data'
  patch 'airports/:iata/' => 'airports#update'

  ## ROUTES ##
  get 'routes/' => 'routes#all'
  get 'routes/:origin/:destination' => 'routes#info'

  ## FLIGHTS ##
  get 'flights/' => 'flights#all'
  get 'flights/:origin/:destination' => 'flights#info'

  ## AIRCRAFT ##
  get 'aircrafts/' => 'aircrafts#all'

end
