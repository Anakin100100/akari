# frozen_string_literal: true

class FlashcardSession < ApplicationRecord
  has_many :flashcards, through: :flashcard_sessions_flashcards
  belongs_to :student
end
