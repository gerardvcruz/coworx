module V1
  class PricingsController < ResourcesController

    private
      def pricing_params
        params.require(:pricing).permit!
      end
  end
end
