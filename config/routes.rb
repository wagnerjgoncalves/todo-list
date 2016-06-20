Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'sessions' },
                     skip: [:registrations, :passwords]

  root 'tasks#index'

  resources :tasks do
    resources :sub_tasks, except: [:new, :show]
  end
end
