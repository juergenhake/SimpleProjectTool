class AddColumnsToProject < ActiveRecord::Migration
  def change
    add_column :projects, :type, :integer
    add_column :projects, :started_at, :datetime, :default => Time.now
    add_column :projects, :finished_at, :datetime
    add_column :projects, :finished_flag, :boolean
    add_column :projects, :reklamation_lief, :string
    add_column :projects, :lief_nr, :string
    add_column :projects, :finished_text, :string
    add_reference :projects, :component, index: true
    add_reference :projects, :user, index: true
  end
end
