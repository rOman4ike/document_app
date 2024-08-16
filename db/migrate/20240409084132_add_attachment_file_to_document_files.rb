class AddAttachmentFileToDocumentFiles < ActiveRecord::Migration[7.0]
  def self.up
    change_table :document_files do |t|
      t.attachment :file
    end
  end

  def self.down
    remove_attachment :document_files, :file
  end
end
