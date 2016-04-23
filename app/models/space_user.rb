class SpaceUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :space

end
