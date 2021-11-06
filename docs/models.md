Student:
    -has and belongs to many parents +
    -belongs to class +
    -has one flashcard session +
Parent:
    -has and belongs to many students +
Teacher:
    -has many classes +
Group:
    -belongs to teacher +
    -has many students +

FlashcardSession:
    -belongs to student +
    -has and belongs to many many flashcards +

flashcard:
    -has and belongs to many flashcard sessions +
    -has many answers +

answer:
    -belongs_to flashcard  +