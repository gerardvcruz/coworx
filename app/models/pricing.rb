class Pricing < ActiveRecord::Base
  extend FriendlyId

  belongs_to :client
  belongs_to :space
  has_many   :plans

  friendly_id :name, use: :slugged
end
