require 'rails_helper'

describe 'Item Multi Finder API' do
  context 'GET /api/v1/items/find_all?paramaters' do
    it 'returns all items by id' do
      id = create(:item).id

      get "/api/v1/items/find_all?id=#{id}"

      items = JSON.parse(response.body)
      item = items.first

      expect(response).to be_successful
      expect(items.class).to eq(Array)
      expect(items.count).to eq(1)
      expect(item['id']).to eq(id)
      expect(item).to have_key('unit_price')
      expect(item).to have_key('description')
      expect(item).to have_key('merchant_id')
    end
    #
    # it 'returns all items by name' do
    #   name = create(:item).name
    #
    #   get "/api/v1/items/find_all?name=#{name}"
    #
    #   item = JSON.parse(response.body)
    #
    #   expect(response).to be_successful
    #   expect(item['name']).to eq(name)
    #   expect(item).to have_key('unit_price')
    #   expect(item).to have_key('description')
    #   expect(item).to have_key('merchant_id')
    # end
    #
    # it 'returns all items by description' do
    #   description = create(:item).description
    #
    #   get "/api/v1/items/find_all?description=#{description}"
    #
    #   item = JSON.parse(response.body)
    #
    #   expect(response).to be_successful
    #   expect(item['description']).to eq(description)
    #   expect(item).to have_key('unit_price')
    #   expect(item).to have_key('description')
    #   expect(item).to have_key('merchant_id')
    # end
    #
    # it 'returns all items by unit price' do
    #   unit_price = create(:item).unit_price
    #
    #   get "/api/v1/items/find_all?unit_price=#{unit_price}"
    #
    #   item = JSON.parse(response.body)
    #
    #   expect(response).to be_successful
    #   expect(item['unit_price']).to eq((unit_price.to_f / 100).round(2).to_s)
    #   expect(item).to have_key('unit_price')
    #   expect(item).to have_key('description')
    #   expect(item).to have_key('merchant_id')
    # end
    #
    # it 'returns all items by merchant id' do
    #   merchant_id = create(:item).merchant_id
    #
    #   get "/api/v1/items/find_all?merchant_id=#{merchant_id}"
    #
    #   item = JSON.parse(response.body)
    #
    #   expect(response).to be_successful
    #   expect(item['merchant_id']).to eq(merchant_id)
    #   expect(item).to have_key('unit_price')
    #   expect(item).to have_key('description')
    #   expect(item).to have_key('merchant_id')
    # end
    #
    # it 'returns all items by created at' do
    #   created_at = create(:item).created_at
    #
    #   get "/api/v1/items/find_all?created_at=#{created_at}"
    #
    #   item = JSON.parse(response.body)
    #
    #   expect(response).to be_successful
    #   expect(item).to have_key('unit_price')
    #   expect(item).to have_key('description')
    #   expect(item).to have_key('merchant_id')
    # end
    #
    # it 'returns all items by updated at' do
    #   updated_at = create(:item).updated_at
    #
    #   get "/api/v1/items/find_all?updated_at=#{updated_at}"
    #
    #   item = JSON.parse(response.body)
    #
    #   expect(response).to be_successful
    #   expect(item).to have_key('unit_price')
    #   expect(item).to have_key('description')
    #   expect(item).to have_key('merchant_id')
    # end
  end
end
