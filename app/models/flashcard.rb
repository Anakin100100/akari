class Flashcard < ApplicationRecord
    has_and_belongs_to_many :flashcard_sessions
    has_many :answers
end
