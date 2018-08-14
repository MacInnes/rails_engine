class Api::V1::InvoicesController < ApplicationController
  def index
    render json: Invoice.all
  end

  def show
    render json: Invoice.find(params[:id])
  end
end
