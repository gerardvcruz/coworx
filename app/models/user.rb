class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable,
         :trackable, :validatable, :registerable,
         :omniauthable

  include DeviseTokenAuth::Concerns::User

   belongs_to :client
   has_many :space_users
   has_many :spaces, through: :space_users
   has_many :reservations
   has_many :invoices
   has_many :payments
   has_many :sessions
   has_one  :plan

end
