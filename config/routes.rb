Rails.application.routes.draw do
  devise_for :users
  root to: 'projects#index'

  resources :projects do
  	resources :tasks, except: [:index, :edit, :new]
  end
end
