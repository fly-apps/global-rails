Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/regions/:code" => "dashboard#region"
  root to: "dashboard#index"
end
