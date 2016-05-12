class CreateTableComponentsCustomers < ActiveRecord::Migration
  def change
    create_table :components_customers do |t|
      t.belongs_to :customer, index: true
      t.belongs_to :component, index: true
    end
  end
end
