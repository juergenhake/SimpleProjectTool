class AddReferenceToProject < ActiveRecord::Migration
  def change
    add_reference :projects, :attachments, index: true
  end
end
