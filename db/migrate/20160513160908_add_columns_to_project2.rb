class AddColumnsToProject2 < ActiveRecord::Migration
  def change
    add_column :projects, :progress, :integer, :default => 0
  end
end
