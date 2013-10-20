class Reservation < ActiveRecord::Base

  belongs_to :owner, :foreign_key => "owner_id", :class_name => "User"
  belongs_to :room

  validates :initial_date, presence: true
  validates :end_date, presence: true
  validates :room_id, presence: true
  validate :interception

  default_scope { order("initial_date ASC") }

  def interception
    reservations =
      Reservation.where(
        '((initial_date BETWEEN :initial_date AND :end_date OR end_date BETWEEN :initial_date AND :end_date)
        OR (initial_date <= :initial_date AND end_date >= :end_date))
        AND room_id = :room_id',
        end_date: end_date, initial_date: initial_date, room_id: room.id)

    if (reservations - [self]).count > 0
      errors.add(:base, 'This reservation has date time insterceped with other reservation.')
    end
  end

end
