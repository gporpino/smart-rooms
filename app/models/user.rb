class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  before_create :create_remember_token
  validates :name, presence: true
  validates :email, presence: true

  has_secure_password

<<<<<<< HEAD
  has_and_belongs_to_many :rooms
=======
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
>>>>>>> 697c7ecf9d7f7ef6b4877e4de523422a6e99078b
end
