class CreateFlashcardSessions < ActiveRecord::Migration[6.1]
  def change
    create_table :flashcard_sessions do |t|
      t.timestamps
    end
  end
end
