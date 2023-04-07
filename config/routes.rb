Rails.application.routes.draw do
  root to: 'users#index'
  resources :users do
    resources :posts do
      resources :comments, :likes
    end
  end
  # post '/users/:user_id/posts/:post_id/likes', to likes#create
end
