Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :twitter do
        get :forecast
      end
    end
  end
end
