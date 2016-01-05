class User < ActiveRecord::Base
  has_secure_password
  has_many :statuses

  has_many :following_relationships, class_name: 'Relationship', foreign_key: 'follower_id'
  has_many :follower_relationships , class_name: 'Relationship', foreign_key: 'leader_id'

  has_many :following_users, through: 'following_relationships', source: 'leader'
  has_many :follower_users, through: 'follower_relationships', source: 'follower'

  validates :username, presence: true
  validates :email, presence: true
  validates :password, presence: true
end