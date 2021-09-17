Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/regions/:code" => "dashboard#region"

  post "/echo" => "dashboard#echo"
  
  resources :timing_results, only: [:index, :create]
  root to: "dashboard#index"
end
