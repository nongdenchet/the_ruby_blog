Rails.application.routes.draw do
  devise_for :users
  root :to => 'articles#index', as: :pages_home

  # articles
  resources :articles do
    post 'search', on: :collection
  end

  # comments
  post 'comments/create'
end
