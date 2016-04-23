module V1
  class InvoicesController < ResourcesController

    private
      def invoice_params
        params.require(:invoice).permit!
      end
  end
end
