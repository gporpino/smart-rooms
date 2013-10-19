class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.datetime :initial_date
      t.datetime :end_date
      t.integer :owner_id

      t.timestamps
    end
  end
end
