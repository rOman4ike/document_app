class AddIsPublicToDocument < ActiveRecord::Migration[7.0]
  def change
    add_column :documents, :is_public, :boolean, default: true
  end
end