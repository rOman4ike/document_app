class AddStateToChangeOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :change_orders, :state, :string, default: 'active'
  end
end
