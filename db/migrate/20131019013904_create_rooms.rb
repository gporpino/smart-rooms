class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.integer :owner_id

      t.timestamps
    end
  end
end
