class Invoice < ActiveRecord::Base
  belongs_to :client
  belongs_to :space
  belongs_to :user

  def pay
  	Payment::PayMaya.new(self)
  end
end
