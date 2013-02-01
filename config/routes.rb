Notification::Application.routes.draw do
  devise_for :users

  resources :users, :only => [] do
    member do
      post :set_courses_with_major
      put :set_role
      get :show_to_be_confirmed_teachers
      put :set_teacher
      put :set_student
    end
  end

  resources :notices

  namespace :administration do
    match 'manage' => 'home#index', :via => :get
  end

  resources :departments do
    collection do
      get :get_majors
    end
  end

  resources :majors
  resources :courses
  resources :questions do
    resources :answers
  end
  match '/search', :to => "search#index"
  root :to => "home#index"
end
