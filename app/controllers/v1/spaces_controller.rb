module V1
  class SpacesController < ResourcesController

    private
      def space_params
        params.require(:space).permit!
      end
  end
end
