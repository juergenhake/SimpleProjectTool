class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.string :description
      t.references :customer, index: true
      t.references :task, index: true
      t.timestamps null: false
    end
  end
end
