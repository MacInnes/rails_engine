class Api::V1::Merchants::MerchantItemsQuantityController < ApplicationController
  def index
    render json: Merchant.most_items(params[:quantity].to_i)
  end
end
