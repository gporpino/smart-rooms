class AddUsersAndRooms < ActiveRecord::Migration
  def self.up
    create_table :rooms_users do |t|
      t.references :room, :user
    end
  end

  def self.down
    drop_table :rooms_users
  end
end
