class CreateProjectItems < ActiveRecord::Migration
  def change
    create_table :project_items do |t|
      t.string :title
      t.string :description
      t.datetime :start
      t.datetime :end
      t.datetime :finished
      t.string :user
      t.timestamps null: false
      t.references :project, index: true
    end
  end
end
