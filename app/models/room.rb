class Room < ActiveRecord::Base
	has_and_belongs_to_many :users
	belongs_to :owner, :foreign_key => "owner_id", :class_name => "User"
  has_many :reservations
  validates :name, presence: true

end
