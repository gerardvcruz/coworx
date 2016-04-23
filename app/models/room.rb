class Room < ActiveRecord::Base
  extend FriendlyId

  belongs_to :client
  belongs_to :space
  has_many :reservations


  friendly_id :name, use: :slugged
end
