# frozen_string_literal: true

class CreateFlashcards < ActiveRecord::Migration[6.1]
  def change
    create_table :flashcards, &:timestamps
  end
end
