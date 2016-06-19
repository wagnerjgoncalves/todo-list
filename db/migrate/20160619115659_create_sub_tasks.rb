class CreateSubTasks < ActiveRecord::Migration
  def change
    create_table :sub_tasks do |t|
      t.string :description, null: false, index: true
      t.references :task, null: false, index: true, foreign_key: true
      t.boolean :completed, null: false, default: false

      t.timestamps null: false
    end
  end
end
