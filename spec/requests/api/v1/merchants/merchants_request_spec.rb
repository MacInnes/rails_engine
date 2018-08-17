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
    merchant = create(:merchant)

    get "/api/v1/merchants/#{merchant.id}"

    response_merchant = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_merchant["name"]).to eq(merchant.name)
  end
  it 'responds to /api/v1/merchants/find?id=x' do
    merchant = create(:merchant)

    get "/api/v1/merchants/find?id=#{merchant.id}"

    response_merchant = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_merchant["id"]).to eq(merchant.id)
  end
  it 'responds to /api/v1/merchants/find?name=x' do
    merchant = create(:merchant)

    get "/api/v1/merchants/find?name=#{merchant.name}"

    response_merchant = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_merchant["id"]).to eq(merchant.id)
  end
  it 'responds to /api/v1/merchants/find?created_at=x' do
    created_at = '2012-03-27 14:54:09 UTC'
    merchant = create(:merchant, created_at: created_at)

    get "/api/v1/merchants/find?created_at=#{created_at}"

    response_merchant = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_merchant["id"]).to eq(merchant.id)
  end
  it 'responds to /api/v1/merchants/find?updated_at=x' do
    updated_at = '2012-03-27 14:54:09 UTC'
    merchant = create(:merchant, updated_at: updated_at)

    get "/api/v1/merchants/find?updated_at=#{updated_at}"

    response_merchant = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_merchant["id"]).to eq(merchant.id)
  end
  it 'responds to /api/v1/merchants/find_all?id=x' do
    merchant = create(:merchant)

    get "/api/v1/merchants/find_all?id=#{merchant.id}"

    response_merchants = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_merchants.first["id"]).to eq(merchant.id)
  end
  it 'responds to /api/v1/merchants/find_all?name=x' do
    merchant = create(:merchant)

    get "/api/v1/merchants/find_all?name=#{merchant.name}"

    response_merchants = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_merchants.first["id"]).to eq(merchant.id)
  end
  it 'responds to /api/v1/merchants/find_all?created_at=x' do
    created_at = '2012-03-27 14:54:09 UTC'
    merchant = create(:merchant, created_at: created_at)

    get "/api/v1/merchants/find_all?created_at=#{created_at}"

    response_merchants = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_merchants.first["id"]).to eq(merchant.id)
  end
  it 'responds to /api/v1/merchants/find_all?updated_at=x' do
    updated_at = '2012-03-27 14:54:09 UTC'
    merchant = create(:merchant, updated_at: updated_at)

    get "/api/v1/merchants/find_all?updated_at=#{updated_at}"

    response_merchants = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_merchants.first["id"]).to eq(merchant.id)
  end
  it 'responds to /api/v1/merchants/random' do
    create_list(:merchant, 4)

    get '/api/v1/merchants/random'

    expect(response).to be_successful
  end


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
  it 'responds to /api/v1/merchants/:id/invoices' do
    merchant = create(:merchant)
    customer = create(:customer)

    create_list(:invoice, 3, merchant_id: merchant.id, customer_id: customer.id)

    get "/api/v1/merchants/#{merchant.id}/invoices"

    invoices = JSON.parse(response.body)
    first_invoice = invoices.first

    expect(response).to be_successful
    expect(invoices.count).to eq(3)
    expect(first_invoice["merchant_id"]).to eq(merchant.id)
  end
end
