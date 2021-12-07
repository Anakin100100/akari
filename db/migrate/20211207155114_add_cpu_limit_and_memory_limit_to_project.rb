class AddCpuLimitAndMemoryLimitToProject < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :cpu_limit, :integer 
    add_column :projects, :memory_limit, :integer
  end
end
