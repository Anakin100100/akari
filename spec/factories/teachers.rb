require 'faker' 

FactoryBot.define do
  factory :teacher do
    name {  Faker::Name.name }
    surname { Faker::Name.last_name }
    email { Faker::Internet.unique.email }
    phone_number { Faker::PhoneNumber.unique.phone_number }
    password { Faker::Internet.password }
    password_confirmation { password }
  end
end
