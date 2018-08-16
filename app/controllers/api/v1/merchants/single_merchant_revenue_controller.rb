class Api::V1::Merchants::SingleMerchantRevenueController < ApplicationController

  def show
    render json: Merchant.find(params[:merchant_id]).revenue, serializer: MerchantDateSerializer
  end

end
