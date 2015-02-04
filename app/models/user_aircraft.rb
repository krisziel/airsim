class UserAircraft < ActiveRecord::Base
  belongs_to :aircraft
  belongs_to :airline
end
