class AddStateToDocumentFile < ActiveRecord::Migration[7.0]
  def change
    add_column :document_files, :state, :string, default: 'active'
  end
end
