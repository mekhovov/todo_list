class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string  :title
      t.text    :description
      t.integer :priopity
      t.enum    :status
      t.integer :list_id

      t.timestamps
    end
  end
end
