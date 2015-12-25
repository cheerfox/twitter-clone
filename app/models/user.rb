class User < ActiveRecord::Base
  has_secure_password
  has_many :statuses

  validates :username, presence: true
  validates :email, presence: true
  validates :password, presence: true
end