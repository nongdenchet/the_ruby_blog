Rails.application.routes.draw do
  resources :articles do
    post 'search', on: :collection
  end
  root :to => 'articles#index', as: :pages_home
  devise_for :users
end
