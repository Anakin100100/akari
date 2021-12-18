require 'faker'

FactoryBot.define do
  factory :student do
    name {  Faker::Name.name }
    surname { Faker::Name.last_name }
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password }
    password_confirmation { password }
  end
end
