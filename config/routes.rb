Rails.application.routes.draw do
  devise_for :students, path: 'students'
  devise_for :admins, path: 'admins'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
