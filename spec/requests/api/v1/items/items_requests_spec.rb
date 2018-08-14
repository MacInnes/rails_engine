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
      expect(item).to have_key('unit_price_to_currency')
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
  end

  context 'GET /api/v1/items/:id/invoice_items' do
    it 'returns a collection of associated invoice items' do
    end
  end

  context 'GET /api/v1/items/:id/merchant' do
    it 'returns the associated merchant' do
    end
  end
end
