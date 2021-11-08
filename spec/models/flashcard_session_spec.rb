# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FlashcardSession, type: :model do
  it 'assures that default session has no flashcards' do
    session = create(:flashcard_session)
    expect(session.flashcards.count).to eq(0)
  end

  it 'assures that flashcard session with flashcards by default contains 5 flashcards' do
    session = create(:flashcard_session_with_flashcards)
    expect(session.flashcards.count).to eq(5)
  end

  it 'assures that flashcard session with specified flashcard count contain the specified number of flashcards' do
    session = create(:flashcard_session_with_flashcards, flashcards_count: 10)
    expect(session.flashcards.count).to eq(10)
  end
end
