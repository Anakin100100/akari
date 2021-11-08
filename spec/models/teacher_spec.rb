# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Teacher, type: :model do
  it 'asserts that name is not nil' do
    teacher = create(:teacher)
    expect(teacher.name).not_to be_nil
  end
end
