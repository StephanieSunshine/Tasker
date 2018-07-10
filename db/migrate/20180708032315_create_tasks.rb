class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.belongs_to :user
      t.string :title, null: false
      t.text :body, null: false
      t.integer :state, default: 0, null: false
      t.integer :assigned_to

      t.timestamps
    end
  end
end
