class Plan < ActiveRecord::Base
  belongs_to :client
  belongs_to :space
  belongs_to :pricing
  has_many   :users


end
