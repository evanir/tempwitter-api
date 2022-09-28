Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :twitter do
        get '/auth/twitter2/callback', to: 'sessions#create'
        post :tweet_forecast
        get :tweet_forecast
        #get :callback
      end
    end
  end
end
