class Api::V1::Items::TopRevenueController < ApplicationController
  def index
    render json: Item.top_revenues(params[:quantity])
  end
end
