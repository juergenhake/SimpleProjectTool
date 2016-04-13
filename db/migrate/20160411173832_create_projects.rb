class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.string :description
      t.references :component, index: true
      t.references :projectItem, index: true
      t.timestamps null: false
    end
  end
end
