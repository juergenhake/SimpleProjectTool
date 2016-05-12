class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.string :message
      t.boolean :systemflag, default: false
      t.references :customer, index: true
      t.references :task, index: true
      t.references :project, index: true
      t.references :component, index: true
      t.references :user, index: true
      t.timestamps null: false
    end
  end
end
