class Api::V1::InvoiceItems::RandomInvoiceItemController < ApplicationController
  def show
    render json: InvoiceItem.order('RANDOM()').limit(1).take
  end
end
