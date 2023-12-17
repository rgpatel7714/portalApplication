Rails.application.routes.draw do
  
  devise_for :students, controllers: { registrations: 'students/registrations',  sessions: 'students/sessions' }
  devise_for :admins, controllers: { sessions: 'admins/sessions' }
  
  devise_scope :student do
    root to: "students/sessions#new"
  end
  resources :student
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
