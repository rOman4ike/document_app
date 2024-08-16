class CreateDocTags < ActiveRecord::Migration[7.0]
  def change
    create_table :doc_tags do |t|
      t.string :title

      t.timestamps
    end
  end
end
