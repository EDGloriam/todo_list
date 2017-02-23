Rails.application.routes.draw do
  devise_for :users
  root to: 'projects#index'

  resources :projects do
  	resources :tasks, except: [:index, :edit, :new] do
  		collection { post :sort_tasks }
  	end
  end
  # match '/sort_task', to: 'tasks#sort_tasks', via: 'POST'
  # match 'projects/:project_id/tasks', to: 'tasks#sort_tasks', via: "POST"
end
