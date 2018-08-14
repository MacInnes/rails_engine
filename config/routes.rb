Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show]
      resources :invoices, only: [:index]
      resources :customers, only: [:index, :show]
      resources :transactions, only: [:index]
    end
  end
end
