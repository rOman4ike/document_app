class AddAttachmentFileToInitialOrders < ActiveRecord::Migration[7.0]
  def self.up
    change_table :initial_orders do |t|
      t.attachment :file
    end
  end

  def self.down
    remove_attachment :initial_orders, :file
  end
end
