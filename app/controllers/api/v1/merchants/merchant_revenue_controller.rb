class Api::V1::Merchants::MerchantRevenueController < ApplicationController

  def index
    params[:quantity] = 5 unless params[:quantity]
    render json: Merchant.most_revenue(params[:quantity].to_i)
  end

  def show
    render json: Merchant.revenue_by_date(params[:date]), each_serializer: MerchantDateSerializer
  end


end
