class AnswerBelongsToFlashcard < ActiveRecord::Migration[6.1]
  def change
    add_reference :answers, :flashcard
  end
end
