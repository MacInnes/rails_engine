class Api::V1::InvoicesController < ApplicationController
  def index
    render json: Invoice.all
  end
end
