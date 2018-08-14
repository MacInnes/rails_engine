require 'rails_helper'

describe 'Items API' do
  context 'GET /api/v1/items' do
    it 'sends a list of all items' do
      create_list(:item, 3)

      get '/api/v1/items'

      items = JSON.parse(response.body)
      item = items.first

      expect(response).to be_successful
      expect(items.count).to eq(3)
      expect(item).to have_key('name')
      expect(item).to have_key('description')
      expect(item).to have_key('unit_price')
      expect(item).to have_key('merchant_id')
    end
  end

  context 'GET /api/v1/items/:id' do
    it 'sends a single item' do
      id = create(:item).id

      get "/api/v1/items/#{id}"

      item = JSON.parse(response.body)

      expect(response).to be_successful
      expect(item['id']).to eq(id)
    end
  end

  context 'GET /api/v1/items/find?paramaters' do
  end

  context 'GET /api/v1/items/find_all?parameters' do
  end

  context 'GET /api/v1/items/random' do
    it 'returns a random item' do
      create_list(:item, 3)

      get '/api/v1/items/random'

      item = JSON.parse(response.body)

      expect(response).to be_successful
      expect(item).to have_key('name')
      expect(item).to have_key('description')
      expect(item).to have_key('unit_price')
      expect(item).to have_key('merchant_id')
    end
  end

  context 'GET /api/v1/items/:id/invoice_items' do
    it 'returns a collection of associated invoice items' do
      item_id = create(:item).id
      create_list(:invoice_item, 3, item_id: item_id)

      get "/api/v1/items/#{item_id}/invoice_items"

      invoice_items = JSON.parse(response.body)
      invoice_item = invoice_items.first

      expect(response).to be_successful
      expect(invoice_items.count).to eq(3)
      expect(invoice_item['item_id']).to eq(item_id)
      expect(invoice_item).to have_key('invoice_id')
      expect(invoice_item).to have_key('quantity')
      expect(invoice_item).to have_key('unit_price')
    end
  end

  context 'GET /api/v1/items/:id/merchant' do
    it 'returns the associated merchant' do
      merchant_id = create(:merchant).id
      item = create(:item, merchant_id: merchant_id)

      get "/api/v1/items/#{item.id}/merchant"

      merchant = JSON.parse(response.body)

      expect(response).to be_successful
      expect(merchant['id']).to eq(merchant_id)
      expect(merchant).to have_key('name')
    end
  end
end
