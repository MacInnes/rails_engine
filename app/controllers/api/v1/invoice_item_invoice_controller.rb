class Api::V1::InvoiceItemInvoiceController < ApplicationController
  def show
    render json: InvoiceItem.includes(:invoice).find(params[:invoice_item_id]).invoice
  end
end
