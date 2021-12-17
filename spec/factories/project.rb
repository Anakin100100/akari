# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :project do
    name {  Faker::Book.author }
    student { create(:student) }
    cpu_limit { Faker::Number.number(250, 500) }
    memory_limit { Faker::Number.number(500, 1000) }
    resource_definitions { Faker::Lorem.paragraph }
  end
end
