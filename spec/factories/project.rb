# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :project do
    name {  Faker::Book.author }
    student { create(:student) }
    cpu_limit { Faker::Number.number(digits: 3) }
    memory_limit { Faker::Number.number(digits: 4) }
    resource_definitions { Faker::Lorem.paragraph }
  end
end
