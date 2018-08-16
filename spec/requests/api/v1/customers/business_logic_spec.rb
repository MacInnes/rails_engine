require 'rails_helper'

describe 'Customer Business Logic API' do
  context 'GET /api/v1/customers/:id/favorite_merchant' do
    it 'returns the merchant where the customer has conducted the most successful transactions' do
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

      get "/api/v1/customers/#{customer.id}/favorite_merchant"

      merchant = JSON.parse(response.body)

      expect(response).to be_successful
      expect(merchant['id']).to eq(merchant_1.id)
      expect(merchant['name']).to eq(merchant_1.name)
    end
  end
end
