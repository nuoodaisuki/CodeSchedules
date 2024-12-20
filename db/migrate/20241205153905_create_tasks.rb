class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :name, null: false
      t.string :explanation, null: false
      t.timestamps
    end
  end
end
