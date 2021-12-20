# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :group do
    name { Faker::Book.author }
  end
end
