Notification::Application.routes.draw do
  devise_for :users

  resources :departments
  resources :questions do
    resources :answers
  end
  match '/search', :to => "search#index"
  root :to => "home#index"
end
