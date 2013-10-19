class Reservation < ActiveRecord::Base

	belongs_to :owner, :foreign_key => "owner_id", :class_name => "User"

	validates_presence_of :initial_date

  def chronic_initial_date
    self.initial_date
  end

  def chronic_initial_date=(s)
    self.initial_date = Chronic.parse(s) if s
  end
end
