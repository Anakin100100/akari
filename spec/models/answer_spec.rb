require 'rails_helper'

RSpec.describe Answer, type: :model do
  it "asserts that flashcard isn't null" do 
    answer = build(:answer)
    expect(answer.flashcard).to_not be_nil
  end
end
