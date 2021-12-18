require 'faker'

FactoryBot.define do
  factory :group do
    name {  Faker::JapaneseMedia::Naruto.character }
  end
end
