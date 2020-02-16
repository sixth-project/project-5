Rails.application.routes.draw do
  root to: 'travels#index'
  get '/search' => 'travels#search'
end
