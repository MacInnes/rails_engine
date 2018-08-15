require 'rails_helper'

describe 'Item Single Finder API' do
  context 'GET /api/v1/items/find?paramaters' do
    it 'returns an item by id' do
      id = create(:item).id

      get "/api/v1/items/find?id=#{id}"

      item = JSON.parse(response.body)

      expect(response).to be_successful
      expect(item['id']).to eq(id)
      expect(item).to have_key('unit_price')
      expect(item).to have_key('description')
      expect(item).to have_key('merchant_id')
    end

    it 'returns an item by name' do
      name = create(:item).name

      get "/api/v1/items/find?name=#{name}"

      item = JSON.parse(response.body)

      expect(response).to be_successful
      expect(item['name']).to eq(name)
      expect(item).to have_key('unit_price')
      expect(item).to have_key('description')
      expect(item).to have_key('merchant_id')
    end

    it 'returns an item by description' do
      description = create(:item).description

      get "/api/v1/items/find?description=#{description}"

      item = JSON.parse(response.body)

      expect(response).to be_successful
      expect(item['description']).to eq(description)
      expect(item).to have_key('unit_price')
      expect(item).to have_key('description')
      expect(item).to have_key('merchant_id')
    end

    # it 'returns an item by unit price' do
    # end
    #
    # it 'returns an item by merchant price' do
    # end
    #
    # it 'returns an item by unit created at' do
    # end
    #
    # it 'returns an item by unit updated at' do
    # end
  end
end