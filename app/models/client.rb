class Client < ActiveRecord::Base
  extend FriendlyId

  has_many :spaces
  has_many :users

  friendly_id :name, use: :slugged

end
