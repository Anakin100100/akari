# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Student, type: :model do
  it 'asserts that name is not nil' do
    student = create(:student)
    expect(student.name).not_to be_nil
  end
end
