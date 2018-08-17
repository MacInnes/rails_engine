class Api::V1::Merchants::MerchantSearchController < ApplicationController
  def index
    render json: Merchant.where(merchant_search_params)
  end
  
  def show
    render json: Merchant.find_by(merchant_search_params)
  end

  private

  def merchant_search_params
    params.permit(:id, :name, :created_at, :updated_at)
  end
end
