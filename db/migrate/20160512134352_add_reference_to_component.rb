class AddReferenceToComponent < ActiveRecord::Migration
  def change
    add_reference :components, :projects, index: true
  end
end
