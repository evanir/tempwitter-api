Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :twitter_forecast do
        get 'callback', to: 'sessions#create'
        post :tweet
      end
    end
  end
end
