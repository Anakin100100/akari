class CreateStudentsGroupsConnectionTable < ActiveRecord::Migration[6.1]
  def change
    create_table :groups_students, id: false do |t|
      t.belongs_to :group
      t.belongs_to :student
    end
  end
end
