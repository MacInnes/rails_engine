class Api::V1::Merchants::MerchantRevenueController < ApplicationController

  def index
    render json: Merchant.most_revenue(params[:quantity].to_i)
  end

  # private
  #
  # def revenue_params
  #   params.permit(:quantity)
  # end
end
