module V1
  class ClientsController < ResourcesController


    private
      def client_params
        params.require(:client).permit!
      end
  end
end
