class CreateInitialOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :initial_orders do |t|
      t.string :number
      t.datetime :initial_date
      t.references :document, foreign_key: true

      t.timestamps
    end
  end
end
