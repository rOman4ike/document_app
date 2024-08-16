class CreateActivityAreas < ActiveRecord::Migration[7.0]
  def change
    create_table :activity_areas do |t|
      t.string :title

      t.timestamps
    end
  end
end
