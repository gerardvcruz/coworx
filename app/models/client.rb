class Client < ActiveRecord::Base
  extend FriendlyId

  has_many :spaces
  has_many :space_users, through: :spaces
  has_many :rooms
  has_many :reservations, through: :rooms
  has_many :users
  has_many :pricings
  has_many :plans

  friendly_id :name, use: :slugged

end
