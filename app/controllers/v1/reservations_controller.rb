module V1
  class ReservationsController < ResourcesController

    private
      def reservation_controller
        params.require(:reservation).permit!
      end
  end
end
