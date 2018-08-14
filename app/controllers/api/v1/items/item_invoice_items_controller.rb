class Api::V1::Items::ItemInvoiceItemsController < ApplicationController
  def index
    render json: Item.includes(:invoice_items).find(params[:item_id]).invoice_items
  end
end
