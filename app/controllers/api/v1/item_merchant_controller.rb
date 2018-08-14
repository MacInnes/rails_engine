class Api::V1::ItemMerchantController < ApplicationController
  def show
    render json: Item.includes(:merchant).find(params[:item_id]).merchant
  end
end
