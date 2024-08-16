class AddDeletedAtToDocumentFile < ActiveRecord::Migration[7.0]
  def change
    add_column :document_files, :deleted_at, :datetime
  end
end
