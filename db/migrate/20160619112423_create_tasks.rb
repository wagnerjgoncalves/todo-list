class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :description, null: false, index: true
      t.integer :kind, null: false, default: 0
      t.references :user, null: false, index: true, foreign_key: true
      t.boolean :completed, null: false, default: false
      t.timestamp :completed_at

      t.timestamps null: false
    end
  end
end
