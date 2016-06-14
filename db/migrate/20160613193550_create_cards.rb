class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :title
      t.text :description
      t.string :urgency
      t.text :details

      t.timestamps null: false
    end
  end
end
