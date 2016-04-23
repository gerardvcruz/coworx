class Space < ActiveRecord::Base
  extend FriendlyId

  belongs_to :client
  has_many :users

  friendly_id :name, use: :slugged

end
