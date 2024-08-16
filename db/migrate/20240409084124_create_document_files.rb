class CreateDocumentFiles < ActiveRecord::Migration[7.0]
  def change
    create_table :document_files do |t|
      t.references :document, foreign_key: true

      t.timestamps
    end
  end
end
