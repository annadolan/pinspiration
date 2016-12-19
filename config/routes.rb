Rails.application.routes.draw do
  resources :boards, only: [:new, :create, :edit, :update, :destroy]

  get '/profile', to: 'profile#show'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  root 'pins#index'

  resources :comments

  resources :pin_boards, only: [:new, :create, :edit, :update, :delete]

  resources :pins, path: 'pin'

  resources :users, only: [:new, :create, :edit, :update]

  get '/:user', to: 'users#show', as: 'show_user'

  namespace :users, as: :user, path: ":user" do
    get '/followers', to: 'followers#index', as: 'followers'
    get '/following', to: 'following#index', as: 'following'
    get '/:board', to: 'boards#show', as: 'board'
  end

  resources :relationships, only: [:create, :destroy]

  get '/dashboard', to: 'users#show'

end
