class CreateComponents < ActiveRecord::Migration
  def change
    create_table :components do |t|
      t.string :component_id_sap
      t.string :name
      t.string :description
      t.timestamps null: false
      t.references :customer, index: true
      t.references :project, index: true
    end
  end
end
