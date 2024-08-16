class CreateChangeOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :change_orders do |t|
      t.string :number
      t.datetime :change_date
      t.references :document, foreign_key: true

      t.timestamps
    end
  end
end
