require 'faker' 

FactoryBot.define do
  factory :answer do
    result { Faker::Boolean.boolean }
    flashcard

    trait :correct do 
      result { true }
    end

    trait :incorrect do
      result { false }
    end

    factory :correct_answer, traits: [:correct]
    factory :incorrect_answer, traits: [:incorrect]
  end
end
