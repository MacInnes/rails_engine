require 'rails_helper'

describe "merchant business logic" do
  it 'responds to /api/v1/merchants/most_revenue?quantity=x correctly' do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    merchant_3 = create(:merchant)

    customer = create(:customer)

    item_1 = create(:item, merchant_id: merchant_1.id)
    item_2 = create(:item, merchant_id: merchant_2.id)
    item_3 = create(:item, merchant_id: merchant_3.id)

    invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant_1.id)
    invoice_2 = create(:invoice, customer_id: customer.id, merchant_id: merchant_2.id)
    invoice_3 = create(:invoice, customer_id: customer.id, merchant_id: merchant_3.id)

    create_list(:invoice_item, 5, item_id: item_1.id, invoice_id: invoice_1.id)
    create_list(:invoice_item, 3, item_id: item_2.id, invoice_id: invoice_2.id)
    create_list(:invoice_item, 1, item_id: item_3.id, invoice_id: invoice_3.id)

    create(:transaction, invoice_id: invoice_1.id)
    create(:transaction, invoice_id: invoice_2.id)
    create(:transaction, invoice_id: invoice_3.id)
    create(:transaction, result: 'failed', invoice_id: invoice_3.id)

    get '/api/v1/merchants/most_revenue?quantity=2'

    response_merchants = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_merchants.count).to eq(2)
    expect(response_merchants.first["id"]).to eq(merchant_1.id)
    expect(response_merchants.first["name"]).to eq(merchant_1.name)
  end

  it 'responds to /api/v1/merchants/most_items?quantity=x correctly' do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    merchant_3 = create(:merchant)
    customer = create(:customer)
    item_1 = create(:item, merchant_id: merchant_1.id)
    item_2 = create(:item, merchant_id: merchant_2.id)
    item_3 = create(:item, merchant_id: merchant_3.id)
    invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant_1.id)
    invoice_2 = create(:invoice, customer_id: customer.id, merchant_id: merchant_2.id)
    invoice_3 = create(:invoice, customer_id: customer.id, merchant_id: merchant_3.id)

    create_list(:invoice_item, 5, item_id: item_1.id, invoice_id: invoice_1.id)
    create_list(:invoice_item, 3, item_id: item_2.id, invoice_id: invoice_2.id)
    create_list(:invoice_item, 1, item_id: item_3.id, invoice_id: invoice_3.id)

    create(:transaction, invoice_id: invoice_1.id)
    create(:transaction, invoice_id: invoice_2.id)
    create(:transaction, invoice_id: invoice_3.id)
    create(:transaction, result: 'failed', invoice_id: invoice_3.id)

    get '/api/v1/merchants/most_items?quantity=2'

    response_merchants = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_merchants.count).to eq(2)
    expect(response_merchants.first["id"]).to eq(merchant_1.id)
    expect(response_merchants.first["name"]).to eq(merchant_1.name)
  end

  it 'responds to /api/v1/merchants/revenue?date=x' do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    merchant_3 = create(:merchant)
    customer = create(:customer)
    item_1 = create(:item, merchant_id: merchant_1.id)
    item_2 = create(:item, merchant_id: merchant_2.id)
    item_3 = create(:item, merchant_id: merchant_3.id)

    bad_date = "2017-08-13".to_date

    invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant_1.id)
    invoice_2 = create(:invoice, customer_id: customer.id, merchant_id: merchant_2.id)
    invoice_3 = create(:invoice, customer_id: customer.id, merchant_id: merchant_3.id, created_at: bad_date)


    create_list(:invoice_item, 5, item_id: item_1.id, invoice_id: invoice_1.id)
    create_list(:invoice_item, 3, item_id: item_2.id, invoice_id: invoice_2.id)
    create_list(:invoice_item, 1, item_id: item_3.id, invoice_id: invoice_3.id)


    create(:transaction, invoice_id: invoice_1.id)
    create(:transaction, invoice_id: invoice_2.id)
    create(:transaction, invoice_id: invoice_3.id)
    create(:transaction, result: 'failed', invoice_id: invoice_3.id)

    get '/api/v1/merchants/revenue?date=2018-08-13'

    response_total = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_total["total_revenue"]).to eq("800.00")
  end

  it 'responds to /api/v1/merchants/:id/revenue' do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    customer = create(:customer)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    create_list(:invoice_item, 5, item_id: item.id, invoice_id: invoice.id)
    create(:transaction, invoice_id: invoice.id)

    get "/api/v1/merchants/#{merchant.id}/revenue"

    response_total = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_total["total_revenue"]).to eq("500.00")

  end
end
