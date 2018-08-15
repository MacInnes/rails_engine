class Api::V1::Invoices::InvoiceCustomerController < ApplicationController
  def show
    render json: Invoice.includes(:customer).find(params[:invoice_id]).customer
  end
end
