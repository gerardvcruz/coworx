module V1
  class SessionsController < ResourcesController
    before_action :find_user

    def checkin
      if @user
        @session = Session.new
        @session.user_id = @user.id
        @session.space_id = params[:session][:space_id]
        @session.client_id = @user.client_id
        @session.start = Time.now
        @session.active = true
        @session.save

        render status: :ok, json: @session.as_json
      else
        render status: :not_found, json: {
          code: 404,
          message: 'User not found.'
        }
      end
    end

    def checkout
      @session = @user.sessions.last
      @session.active = false
      @session.end = Time.now
      @session.save

      render status: :ok, json: @session.as_json
    end

    private
      def session_params
        params.require(:session).permit(:email, :space_id)
      end

      def find_user
        @user = User.find_by_email(session_params[:email])
      end
  end
end
