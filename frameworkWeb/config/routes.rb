Rails.application.routes.draw do
  get 'control_users/index'
  get 'control_users/new'

  post 'control_users', to: 'control_users#create', as: "new_user"

  delete '/alunos_departamentos/:id', to: 'alunos_departamentos#destroy', as: 'delete_aluno_departamento'

  devise_for :users

  resources :control_users
  resources :matriculas
  resources :alunos
  resources :estados
  resources :departamentos
  resources :alunos_departamentos
  
  root 'main#index'
  get 'inicio' => 'main#index'
  

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
