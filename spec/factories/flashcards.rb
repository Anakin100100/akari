# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :flashcard do
    question { Faker::Lorem.question }
    answer { Faker::Lorem.sentence }
  end
end
