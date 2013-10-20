class Reservation < ActiveRecord::Base

  belongs_to :owner, :foreign_key => "owner_id", :class_name => "User"
  belongs_to :room

  validates :initial_date, presence: true
  validates :end_date, presence: true
  validates :room_id, presence: true

  validate :interception
  validate :initial_date_cannot_be_in_the_past
  validate :end_date_grather_than_initial_date

  default_scope { order("initial_date ASC") }

  def interception
    count =
    Reservation.where(
    '(initial_date BETWEEN :initial_date AND :end_date OR end_date BETWEEN :initial_date AND :end_date) OR (initial_date <= :initial_date AND end_date >= :end_date)',
     end_date: end_date, initial_date: initial_date).count

    if count > 0
      errors.add(:base, 'This reservation has intercession date / time with another reservation')
    end
  end

  def initial_date_cannot_be_in_the_past
    errors.add(:initial_date, "can't be in the past") if
      !initial_date.blank? and initial_date < Date.today
  end

  def end_date_grather_than_initial_date
    errors.add(:end_date, "must be grather than initial date") if
      end_date <= initial_date 
  end

end
