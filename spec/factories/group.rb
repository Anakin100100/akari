# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :group do
    name {  Faker::GreekPhilosophers.name }
    teacher { create(:teacher) }
    group_project_references { create_list(:group_project_reference, 5) }
  end
end
