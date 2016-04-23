class Space < ActiveRecord::Base
  extend FriendlyId

  belongs_to :client
  has_many :users, through: :space_users
  has_many :rooms
  has_many :reservations
  has_many :invoices
  has_many :payments

  friendly_id :name, use: :slugged

end
