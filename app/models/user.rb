class User < ActiveRecord::Base
  before_save { self.email = email.downcase unless :guest? }
  before_create :create_remember_token
  validates :name, presence: true
  validates :email, presence: true, unless: :guest?
  validates :name, uniqueness: true, allow_blank: true

  has_secure_password

  has_many :room_user, :dependent => :destroy
  has_many :associations, :through => :room_user, :source => :room,  :dependent => :destroy
  has_many :rooms, :foreign_key => 'owner_id'
  has_many :reservations, :foreign_key => 'owner_id'

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def self.new_guest
    random = rand(36**6).to_s(36)
    new guest: true, password: "guest", password_confirmation: "guest", name: "Guest_#{random}"
  end

  def move_to(user)
    rooms.update_all(owner_id: user.id)
    reservations.update_all(owner_id: user.id)
    room_user.update_all(user_id: user.id)
  end

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
