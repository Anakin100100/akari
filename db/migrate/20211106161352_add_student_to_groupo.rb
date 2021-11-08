# frozen_string_literal: true

class AddStudentToGroupo < ActiveRecord::Migration[6.1]
  def change
    add_reference :students, :group
  end
end
