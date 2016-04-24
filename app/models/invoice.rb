class Invoice < ActiveRecord::Base
  belongs_to :client
  belongs_to :space
  belongs_to :user

	before_save :create_payment_link

  def create_payment_link
  	if self.info.blank?
  		self.info = {}
  	end

  	Payment::Paymaya.new(self).generate_info
  end
end