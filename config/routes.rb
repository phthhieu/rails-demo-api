Rails.application.routes.draw do
  resources :libraries do
    resources :books
  end
end
