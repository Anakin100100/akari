# frozen_string_literal: true

class CreateFlashcardSessions < ActiveRecord::Migration[6.1]
  def change
    create_table :flashcard_sessions, &:timestamps
  end
end
