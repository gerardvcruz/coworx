class Reservation < ActiveRecord::Base
  belongs_to :client
  belongs_to :space
  belongs_to :room
  belongs_to :user

end
