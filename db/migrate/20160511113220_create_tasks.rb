class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :description
      t.datetime :start
      t.datetime :end
      t.datetime :finished
      t.string :user
      t.timestamps null: false
      t.references :project, index: true
      t.references :user, index: true
      t.references :attachments, index: true
      t.references :historys, index: true
    end
  end
end
