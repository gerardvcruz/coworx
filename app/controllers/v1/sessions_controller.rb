module V1
  class SessionsController < ResourcesController
    before_action :find_user

    def checkin
      if @session = Session.create_session(@user)

      end
    end

    def checkout

    end

    private
      def session_params
        params.require(:session).permit(:email)
      end

      def find_user
        @user = User.find_by_email(params[:email])
      end
  end
end
