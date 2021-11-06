class FlashcardAndFlashcardSessionTables < ActiveRecord::Migration[6.1]
  def change
    add_reference :flashcard_sessions, :student

    #create a table with has and belongs to many relatio between flashcards and flashcard_sessions
    create_table :flashcard_flashcard_sessions, id: false do |t|
      t.belongs_to :flashcard
      t.belongs_to :flashcard_session
    end
  end
end
