class Pricing < ActiveRecord::Base
  extend FriendlyId

  belongs_to :client
  belongs_to :space

  friendly_id :name, use: :slugged
end
