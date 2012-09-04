Notification::Application.routes.draw do
  devise_for :users
  resources :departments
  resources :questions do
    resources :answers
  end
  root :to => "home#index"
end
