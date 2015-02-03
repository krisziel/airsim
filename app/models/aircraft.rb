class Aircraft < ActiveRecord::Base
  has_many :user_aircraft

  def full_name
    "#{manufacturer} #{name}"
  end

end
