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
    invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant_1.id)
    invoice_2 = create(:invoice, customer_id: customer.id, merchant_id: merchant_2.id)
    invoice_3 = create(:invoice, customer_id: customer.id, merchant_id: merchant_3.id)

    create_list(:invoice_item, 5, item_id: item_1.id, invoice_id: invoice_1.id)
    create_list(:invoice_item, 3, item_id: item_2.id, invoice_id: invoice_2.id)
    create_list(:invoice_item, 1, item_id: item_3.id, invoice_id: invoice_3.id)

    create(:transaction, invoice_id: invoice_1.id)
    create(:transaction, invoice_id: invoice_2.id)
    create(:transaction, invoice_id: invoice_3.id, created_at: "2017-08-13 20:49:53")
    create(:transaction, result: 'failed', invoice_id: invoice_3.id)

    get '/api/v1/merchants/revenue?date=2018-08-13'

    response_total = JSON.parse(response.body)
    expect(response).to be_successful
    binding.pry
    expect(response_total.first["total_revenue"]).to eq("900.00")
  end
end
