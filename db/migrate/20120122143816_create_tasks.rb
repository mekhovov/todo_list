class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string  :title
      t.text    :description
      t.enum    :priority
      t.enum    :status
      t.integer :list_id

      t.timestamps
    end
  end
end
