require 'rails_helper'

describe 'Merchants API' do
  it 'responds to /api/v1/merchants' do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    merchants = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchants.count).to eq(3)
  end
  it 'responds to /api/v1/merchant/:id' do
    merchant = Merchant.create(name: "asdf")

    get "/api/v1/merchants/#{merchant.id}"
    
    response_merchant = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_merchant["name"]).to eq(merchant["name"])
  end
end
