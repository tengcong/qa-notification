Notification::Application.routes.draw do
  devise_for :users

  resources :users, :only => [] do
    member do
      post :set_courses_with_major
    end
  end

  resources :departments
  resources :questions do
    resources :answers
  end
  match '/search', :to => "search#index"
  root :to => "home#index"
end
