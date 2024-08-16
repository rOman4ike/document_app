class CreateDocumentDocTags < ActiveRecord::Migration[7.0]
  def change
    create_table :document_doc_tags do |t|
      t.references :document, foreign_key: true
      t.references :doc_tag, foreign_key: true

      t.timestamps
    end
  end
end
