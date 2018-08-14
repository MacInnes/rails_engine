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
end
