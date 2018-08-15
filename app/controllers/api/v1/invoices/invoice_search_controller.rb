class Api::V1::Invoices::InvoiceSearchController < ApplicationController
  def index
    render json: Invoice.where(invoice_search_params)
  end

  def show
    render json: Invoice.find_by(invoice_search_params)
  end

  private

  def invoice_search_params
    params.permit(:id, :customer_id, :merchant_id, :status, :created_at, :updated_at)
  end
end
