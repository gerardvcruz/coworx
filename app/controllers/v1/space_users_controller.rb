module V1
  class SpaceUsersController < ResourcesController

    private
      def space_user_params
        params.require(:space_user).permit!
      end
  end
end
