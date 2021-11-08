# frozen_string_literal: true

FactoryBot.define do
  factory :group do
    name { Faker::Space.planet }
    teacher

    factory :group_with_students do
      transient do
        students_count { 5 }
      end

      after(:create) do |group, evaluator|
        create_list(:student, evaluator.students_count, group: group)
      end
    end
  end
end
