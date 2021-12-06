class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.string :name
      t.belongs_to :teacher
      t.timestamps
    end
  end
end
