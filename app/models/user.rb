class User < ActiveRecord::Base
  validates :name, presence: true
  validates :email, presence: true

  has_secure_password

  has_and_belongs_to_many :rooms
end
