module V1
  class UsersController < ResourcesController

  	def active
  		if params[:client_id]
  			@client = Client.find(params[:client_id])
  			@active_users = []
  			@client.users.each do |user|
  				if user.active_now?
            _user = user.attributes
            _user['spaces'] = user.spaces
  					@active_users << _user
  				end
  			end

  			if @active_users.empty?
  				render status: :no_content, json: {
  					code: 404, message: 'no users found.'
  				}
  			else
  				render status: :ok, json: @active_users.as_json
  			end
  		end
  	end

    private
      def user_params
        params.require(:user).permit!
      end
  end
end
