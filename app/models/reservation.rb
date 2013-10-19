class Reservation < ActiveRecord::Base

	belongs_to :owner, :foreign_key => "owner_id", :class_name => "User"
  belongs_to :room

	validates :initial_date, presence: true
  validates :end_date, presence: true
  validates :room_id, presence: true

  default_scope order("initial_date ASC")
  scope :future, joins(:room).where("initial_date > ?", Date.today)

end
