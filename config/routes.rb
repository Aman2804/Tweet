Rails.application.routes.draw do
  devise_for :users, skip: [:registrations, :sessions]
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      post 'follow_and_unfollow', to: "followers#follow_and_unfollow"
      get 'All_tweet_of_followed_user', to: 'tweet#All_tweet_of_followed_user'
      get 'tweet_of_user/:id', to: 'tweet#tweet_of_user'
      resources :tweet
      devise_for :users, controllers: { sessions: 'api/v1/sessions', registrations: 'api/v1/registrations' }
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
