class Reservation < ActiveRecord::Base

	belongs_to :owner, :foreign_key => "owner_id", :class_name => "User"
  belongs_to :room

	validates :initial_date, presence: true
  validates :end_date, presence: true
  validates :room_id, presence: true

end
