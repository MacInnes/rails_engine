class Api::V1::InvoiceItems::InvoiceItemSearchController < ApplicationController
  def index
    render json: InvoiceItem.where(invoice_item_search_params)
  end

  def show
    render json: InvoiceItem.find_by(invoice_item_search_params)
  end

  private

  def invoice_item_search_params
    params[:unit_price] = params[:unit_price].delete('.').to_i if params[:unit_price]
    params.permit(:id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at)
  end
end
