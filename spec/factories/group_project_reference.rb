# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :group_project_reference do
    name { Faker::FunnyName.two_word_name }
    projects { create_list(:project, 5) }
  end
end
