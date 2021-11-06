class AddingModelFields < ActiveRecord::Migration[6.1]
  def change
    add_column :answers, :result, :boolean 
    add_column :flashcards, :question, :text
    add_column :flashcards, :answer, :text 
    add_column :groups, :name, :string
    add_column :parents, :name, :string
    add_column :parents, :surname, :string
    add_column :parents, :phone_number, :string
    add_column :teachers, :name, :string
    add_column :teachers, :surname, :string
    add_column :teachers, :phone_number, :string
    add_column :students, :name, :string
    add_column :students, :surname, :string
    add_column :students, :date_of_birth, :date 
  end
end
