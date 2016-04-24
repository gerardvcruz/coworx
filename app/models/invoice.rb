class Invoice < ActiveRecord::Base
  belongs_to :client
  belongs_to :space
  belongs_to :user

	after_create :create_payment_link

  def create_payment_link
  	if self.info.blank?
  		self.info = {}
  	end

  	self.info['payment_link'] = Payment::Paymaya.new(self).link
  end
end