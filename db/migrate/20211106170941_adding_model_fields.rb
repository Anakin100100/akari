# frozen_string_literal: true

class AddingModelFields < ActiveRecord::Migration[6.1]
  def change
    add_column :teachers, :name, :string
    add_column :teachers, :surname, :string
    add_column :teachers, :phone_number, :string
    add_column :students, :name, :string
    add_column :students, :surname, :string
    add_column :students, :date_of_birth, :date
  end
end
