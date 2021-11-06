class CreateParentsToStudentsTable < ActiveRecord::Migration[6.1]
  def change
    #student has and belongs to many parents
    create_table :parents_students, id: false do |t|
      t.belongs_to :student, index: true
      t.belongs_to :parent, index: true
    end
  end
end
