class DeleteSomeFieldsFromTeachersAndStudents < ActiveRecord::Migration[6.1]
  def change
    remove_column :students, :date_of_birth
    remove_column :teachers, :phone_number
  end
end
