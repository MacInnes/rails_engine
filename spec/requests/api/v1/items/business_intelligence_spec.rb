require 'rails_helper'

describe 'Item Business Logic' do
  context 'GET /api/v1/items/most_revenue?quantity=x' do
    it 'returns the top items x items ranked by total revenue generated' do
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

      get '/api/v1/items/most_revenue?quantity=2'

      items = JSON.parse(response.body)
      top_item = items.first

      expect(response).to be_successful
      expect(items.count).to eq(2)
      expect(top_item).to have_key('name')
      expect(top_item).to have_key('description')
      expect(top_item).to have_key('unit_price')
      expect(top_item).to have_key('merchant_id')
    end
  end

  context 'GET /api/v1/items/most_items?quantity=x' do
    it 'returns the top items x items ranked by total number sold' do
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

      get '/api/v1/items/most_items?quantity=2'

      items = JSON.parse(response.body)
      top_item = items.first

      expect(response).to be_successful
      expect(items.count).to eq(2)
      expect(top_item).to have_key('name')
      expect(top_item).to have_key('description')
      expect(top_item).to have_key('unit_price')
      expect(top_item).to have_key('merchant_id')
    end
  end
end
