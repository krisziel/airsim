Rails.application.routes.draw do

  root 'app#index'

  ## AIRPORTS ##
  get 'airports/scrape/:country' => 'airports#scrape'
  get 'airports/' => 'airports#all'
  get 'airports/:iata' => 'airports#data'
  patch 'airports/:iata/' => 'airports#update'

end
