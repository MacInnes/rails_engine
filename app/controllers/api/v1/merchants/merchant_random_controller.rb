class Api::V1::Merchants::MerchantRandomController < ApplicationController
  def show
    render json: Merchant.order('RANDOM()').limit(1).take
  end
end
