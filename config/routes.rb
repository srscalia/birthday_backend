Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :messages, :reminders, :users
      post 'user_token' => 'user_token#create'
      get 'users/current' => 'users#current'
    end
  end
end
