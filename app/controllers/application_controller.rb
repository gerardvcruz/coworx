class ApplicationController < ActionController::API
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  include DeviseTokenAuth::Concerns::SetUserByToken
end
