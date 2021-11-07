require 'faker' 

FactoryBot.define do
  factory :answer do
    result { Faker::Boolean.boolean }
    flashcard

    train :correct do 
      result { true }
    end

    train :incorrect do
      result { false }
    end

  end
end
