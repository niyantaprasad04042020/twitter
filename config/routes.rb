Rails.application.routes.draw do
  devise_for :users
  resources :tweets do
    resources :comments
  end
  get '/search', to: 'tweets#search'
  post '/retweet', to: 'tweets#retweet'
  root to: "tweets#index"
end
