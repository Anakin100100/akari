class CreateParentsToStudentsTable < ActiveRecord::Migration[6.1]
  def change
    #student has and belongs to many parents
    create_table :parents_students, id: false do |t|
      t.belongs_to :student
      t.belongs_to :parent
    end
  end
end
