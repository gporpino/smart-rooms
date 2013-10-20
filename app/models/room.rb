class Room < ActiveRecord::Base
  has_many :room_user, :dependent => :destroy
  has_many :users, :through => :room_user, :after_remove => :remove_reservations
	belongs_to :owner, :foreign_key => "owner_id", :class_name => "User"
  has_many :reservations, :dependent => :destroy
  validates :name, presence: true

  private

    def remove_reservations(user)
      self.reservations.where('owner_id = ?', user.id).delete_all
    end

end
