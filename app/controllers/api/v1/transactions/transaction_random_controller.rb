class Api::V1::Transactions::TransactionRandomController < ApplicationController

  def show
    render json: Transaction.order('RANDOM()').limit(1).take
  end

end
