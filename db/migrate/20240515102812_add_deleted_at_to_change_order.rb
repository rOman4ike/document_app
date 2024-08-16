class AddDeletedAtToChangeOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :change_orders, :deleted_at, :datetime
  end
end
