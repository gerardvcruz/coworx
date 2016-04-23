module V1
  class SessionsController < ResourcesController


    private
      def session_params
        params.require(:sessions).permit!
      end
  end
end
