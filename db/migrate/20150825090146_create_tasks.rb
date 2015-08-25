class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.integer :priority
      t.date :due_date
      t.boolean :completed, default: false

      t.timestamps
    end
  end
end
