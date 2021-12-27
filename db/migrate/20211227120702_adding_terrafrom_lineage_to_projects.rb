class AddingTerrafromLineageToProjects < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :terraform_lineage, :string
  end
end
