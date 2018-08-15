class Api::V1::Customers::CustomerInvoicesController < ApplicationController

  def index
    render json: Customer.includes(:invoices).find(params[:customer_id]).invoices
  end

end
