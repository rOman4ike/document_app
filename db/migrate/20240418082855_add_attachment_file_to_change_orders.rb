class AddAttachmentFileToChangeOrders < ActiveRecord::Migration[7.0]
  def self.up
    change_table :change_orders do |t|
      t.attachment :file
    end
  end

  def self.down
    remove_attachment :change_orders, :file
  end
end
