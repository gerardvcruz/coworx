class Invoice < ActiveRecord::Base
  belongs_to :client
  belongs_to :space
  belongs_to :user

	before_save :create_payment_link

  def create_payment_link
  	if self.info.blank?
  		self.info = {}
  	end
    self.info['payment_link'] =  Payment::Paymaya.new(self).create_payment_link
  end
end