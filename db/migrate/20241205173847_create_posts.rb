class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :task, null: false, foreign_key: true
      t.integer :time_taken
      t.text :note
      t.datetime :start, null: false
      t.datetime :end, null: false
      t.boolean :is_completion, default: false, null: false
      t.timestamps
    end
  end
end
