class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_airline
    Airline.find_by(id: cookies.signed[:airlineid])
  end

  helper_method :current_airline

end
