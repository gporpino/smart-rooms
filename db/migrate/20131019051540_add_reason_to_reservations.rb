class AddReasonToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :reason, :string
  end
end
