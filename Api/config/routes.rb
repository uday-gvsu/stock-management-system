Rails.application.routes.draw do
  resources :stock_details , defaults: { format: :json } do
    collection do
      get :profit, to: 'stock_details#profit', format: 'json'
      get :stock_profit, to: 'stock_details#stock_profit', format: 'json'
    end
  end
  resources :stocks, defaults: { format: :json }
  mount_devise_token_auth_for 'User', at: 'auth'
  # resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
