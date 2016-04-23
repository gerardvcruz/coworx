module V1
  class RoomsController < ResourcesController

    private
      def room_params
        params.require(:room).permit!
      end
  end
end
