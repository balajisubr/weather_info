Rails.application.routes.draw do
  get 'weather/query'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  get "/query_weather" => "weather#query"
  get "/weather_info" => "weather#retrieve_weather_info", as: :retrieve_weather_info

  # Defines the root path route ("/")
  # root "posts#index"
end
