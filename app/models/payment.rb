class Payment < ActiveRecord::Base
  belongs_to :client
  belongs_to :space
  belongs_to :user
  belongs_to :invoice


end
