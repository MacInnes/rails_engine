class Api::V1::Merchants::MerchantInvoicesController < ApplicationController
  def index
    render json: Merchant.includes(:invoices).find(params[:merchant_id]).invoices
  end
end
