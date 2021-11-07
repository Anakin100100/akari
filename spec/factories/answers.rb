require 'faker' 

FactoryBot.define do
  factory :answer do
    result { Faker::Boolean.boolean }
    flashcard
  end
end
