class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.belongs_to :task, foreign_key: true
      t.integer :user
      t.text :data

      t.timestamps
    end
  end
end
