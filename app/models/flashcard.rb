# frozen_string_literal: true

class Flashcard < ApplicationRecord
  has_many :flashcard_sessions, through: :flashcard_sessions_flashcards
  has_many :answers, dependent: :destroy
end
