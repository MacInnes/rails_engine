require 'rails_helper'

describe 'Merchants API' do
  xit 'responds to /api/v1/merchants' do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful
  end
end
