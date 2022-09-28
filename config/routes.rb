Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :twitter do
        post :tweet_forecast
        get :tweet_forecast
        get :callback
      end
    end
  end
end
