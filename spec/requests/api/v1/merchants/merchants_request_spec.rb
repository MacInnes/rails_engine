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
  # TODO: get /api/v1/merchants/find?parameters
  # TODO: get /api/v1/merchants/find_all?parameters
  # TODO: get /api/v1/merchants/random

  it 'responds to /api/v1/merchants/:id/items' do
    merchant = create(:merchant)

    create_list(:item, 3, merchant_id: merchant.id)

    get "/api/v1/merchants/#{merchant.id}/items"

    items = JSON.parse(response.body)
    first_item = items.first

    expect(response).to be_successful
    expect(items.count).to eq(3)
    expect(first_item['merchant_id']).to eq(merchant.id)

  end
end
