# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :students, path: 'students'
  devise_for :parents, path: 'parents'
  devise_for :teachers, path: 'teachers'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'pages#home'
  get 'logins' => 'pages#logins'
  get 'registrations' => 'pages#registrations'
end
