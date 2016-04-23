module V1
  class PaymentsController < ResourcesController

    private
      def payment_params
        params.require(:payment).permit!
      end
  end
end
