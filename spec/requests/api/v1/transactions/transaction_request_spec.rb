require 'rails_helper'

describe 'Transaction API' do
  it 'responds to /api/v1/transactions' do
    create_list(:transaction, 3)

    visit '/api/v1/transactions'

    transactions = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transactions.length).to eq(3)
  end
end
