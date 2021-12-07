class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :name
      t.belongs_to :student 
      t.belongs_to :group 
      t.text :resource_definitions, null: false, default: ''
      t.timestamps
    end
  end
end
