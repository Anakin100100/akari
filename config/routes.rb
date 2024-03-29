# frozen_string_literal: true

Rails.application.routes.draw do
  resources :group_project_references
  devise_for :students, path: 'students'
  devise_for :teachers, path: 'teachers'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'pages#home'
  get 'logins' => 'pages#logins'
  get 'registrations' => 'pages#registrations'
  get 'student_dashboard' => 'students#student_dashboard', as: :student_dashboard
  get 'teacher_dashboard' => 'teachers#teacher_dashboard', as: :teacher_dashboard
  get 'groups' => 'groups#index', as: :groups
  get 'new_group' => 'groups#new', as: :new_group
  post 'groups' => 'groups#create'
  get 'groups/:id' => 'groups#show', as: :group
  delete 'groups/:id' => 'groups#destroy', as: :delete_group
  post 'projects' => 'projects#create'
  get 'new_project' => 'projects#new', as: :new_project
  get 'projects/:id' => 'projects#show', as: :project
  get 'modify_project/:id' => 'projects#edit', as: :modify_project
  delete 'projects/:id' => 'projects#destroy', as: :delete_project
  get 'group_project/:id' => 'group_project_references#show', as: :group_project
  patch "projects/:id" => "projects#update", as: :update_project
  delete 'group_project/:id' => 'group_project_references#delete', as: :delete_group_project
end
