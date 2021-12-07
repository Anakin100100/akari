class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :group_project_references do |t|
      t.timestamps
      t.string :name 
      t.belongs_to :group
    end


    create_table :projects do |t|
      t.string :name
      t.belongs_to :student 
      t.belongs_to :group_project_reference
      t.text :resource_definitions, null: false, default: ''
      t.timestamps
    end
  end
end
