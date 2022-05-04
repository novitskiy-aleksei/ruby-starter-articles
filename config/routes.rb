Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "articles#index"

  # get "/articles", to: "articles#index"
  resources :articles
  get '/my-articles', to: 'articles#index_my'

  mount ActionCable.server, at: '/cable'
end
