class Reservation < ActiveRecord::Base

  belongs_to :owner, :foreign_key => "owner_id", :class_name => "User"
  belongs_to :room

  validates :initial_date, presence: true
  validates :end_date, presence: true
  validates :room_id, presence: true

  validate :interception, on: :create

  default_scope order("initial_date ASC")



  def interception
    reservations = Reservation.where('(initial_date < ? and end_date > ?) or (end_date > ? and initial_date < ?)',
     end_date, end_date, initial_date, initial_date, initial_date, end_date)

    if reservations.count > 0
      errors.add(:base, 'This reservation has date time insterceped with other reservation.')
    end
  end

end
