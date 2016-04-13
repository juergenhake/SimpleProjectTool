class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name
      t.string :description
      t.string :customer_id_sap
      t.timestamps null: false
      t.references :components, index: true
    end
  end
end
