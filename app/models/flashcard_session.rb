class FlashcardSession < ApplicationRecord
    has_and_belongs_to_many :flashcards
    belongs_to :student
end
