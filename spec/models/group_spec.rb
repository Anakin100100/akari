# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Group, type: :model do
  it 'assures that default group has no students' do
    group = create(:group)
    expect(group.students.count).to eq(0)
  end

  it 'assures that default group with students has 5 students' do
    group = create(:group_with_students)
    expect(group.students.count).to eq(5)
  end

  it 'assures that group with students with specified student count has the specified number of students' do
    group = create(:group_with_students, students_count: 10)
    expect(group.students.count).to eq(10)
  end

  it 'assures that each student in group belongs to the same group' do
    group = create(:group_with_students)
    group.students.each do |student|
      expect(student.group).to eq(group)
    end
  end
end
