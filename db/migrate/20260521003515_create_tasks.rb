class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.references :project, null: false, foreign_key: true
      t.string :description
      t.boolean :completed, default: false, null: false

      t.timestamps
    end
  end
end
