class CreateDocumentActivityAreas < ActiveRecord::Migration[7.0]
  def change
    create_table :document_activity_areas do |t|
      t.references :document, foreign_key: true
      t.references :activity_area, foreign_key: true

      t.timestamps
    end
  end
end
