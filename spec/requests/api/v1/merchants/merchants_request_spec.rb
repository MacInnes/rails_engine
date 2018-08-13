require 'rails_helper'

describe 'Merchants API' do
  xit 'responds to /api/v1/merchants' do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    merchants = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchants.count).to eq(3)
  end
end
