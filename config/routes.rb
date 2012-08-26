Notification::Application.routes.draw do
  resources :departments
  resources :questions do
    resources :answers
  end
end
