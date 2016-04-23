module V1
  class PlansController < ResourcesController

    private
      def plan_params
        params.require(:plan).permit!
      end
  end
end
