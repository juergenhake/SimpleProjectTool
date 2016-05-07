class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.attachment :file
      t.datetime :upload_at, :null => false, :default => Time.now
      t.timestamps null: false
      t.references :customer, index: true
      t.references :projectItem, index: true
      t.references :project, index: true
      t.references :component, index: true
      t.references :user, index: true
    end
  end
end
