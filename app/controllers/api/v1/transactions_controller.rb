class Api::V1::TransactionsController < ApplicationController
  def index
    render json: Transaction.all
  end
end
