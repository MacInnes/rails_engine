class Api::V1::Merchants::CustomersWithPendingInvoicesController < ApplicationController
  def index
    render json: Merchant.find(params[:merchant_id]).customers_with_pending_invoices, each_serializer: CustomerSerializer
  end
end
