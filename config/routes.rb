Rails.application.routes.draw do
  resources :articles
  root :to => 'articles#index', as: :pages_home
  devise_for :users
end
