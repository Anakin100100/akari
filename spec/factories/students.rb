# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :student do
    name {  Faker::Name.name }
    surname { Faker::Name.last_name }
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password }
    password_confirmation { password }
    date_of_birth { Faker::Date.birthday(min_age: 5, max_age: 8) }
    group
  end
end
