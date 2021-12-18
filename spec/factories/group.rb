require 'faker'

FactoryBot.define do
  factory :group do
    name {  Faker::GreekPhilosophers.name }
  end
end
