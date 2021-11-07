FactoryBot.define do
  factory :flashcard_session do
    student

    factory :flashcard_session_with_flashcards do
      transient do
        flashcards_count { 5 }
      end

      flashcards do
        Array.new(flashcards_count) { association(:flashcard) }
      end
    end
  end
end
