class Api::V1::InvoiceItemsController < ApplicationController
  def index
    render json: InvoiceItem.all
  end
end
