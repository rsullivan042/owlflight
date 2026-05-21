class AddCurrentToProjects < ActiveRecord::Migration[8.0]
  def change
    add_column :projects, :current, :boolean
    add_index :projects, :current, unique: true, where: "current = true"
  end
end
