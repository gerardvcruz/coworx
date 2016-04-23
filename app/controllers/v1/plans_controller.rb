module V1
  class PlansController

    private
      def plan_params
        params.require(:plan).permit!
      end
  end
end
