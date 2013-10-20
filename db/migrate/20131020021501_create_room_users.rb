class CreateRoomUsers < ActiveRecord::Migration
  def change
    create_table :room_users do |t|
      t.references :room, :user
    end
  end
end
