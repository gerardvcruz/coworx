class Plan < ActiveRecord::Base
  belongs_to :client
  belongs_to :space
  has_many   :users
  has_one    :pricing


end
