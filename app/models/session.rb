class Session < ActiveRecord::Base
  belongs_to :user
  belongs_to :space
  belongs_to :client

  def create_session user

  end

  def active?
  	self.active
  end
end
