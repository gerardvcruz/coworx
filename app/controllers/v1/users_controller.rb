module V1
  class UsersController < ResourcesController

    private
      def user_params
        params.require(:user).permit!
      end
  end
end
