class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :tweets
  has_many :favorites

  has_many :follows
  has_many :following_users, through: :follows, source: :User
  has_many :inverse_follows, class_name: Follow, foreign_key: :followed_id
  has_many :followed_users, through: :inverse_follows

  def followded? User
    Follow.exists?(user_id: user.id, followded_id: self.id)
  end
end
