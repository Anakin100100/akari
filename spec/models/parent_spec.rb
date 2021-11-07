require 'rails_helper'

RSpec.describe Parent, type: :model do
  it 'asserts that name is not nil' do
    parent = create(:parent)
    expect(parent.name).not_to be_nil
  end
end
