class User < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :microposts, dependent: :destroy
  has_many :collections, foreign_key: "collecter_id",
                         dependent:   :destroy
  has_many :collecting, through: :collections, source: :collected                    
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
	attr_accessor :remember_token
	before_save { self.email = email.downcase }
	validates :name, length: { in: 9..30 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, 
               format: { with: VALID_EMAIL_REGEX },
               uniqueness: { case_sensitive: false }
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
    validates :password_confirmation, presence: true
    has_secure_password

    # Returns the hash digest of a string.
    def User.digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    # Returns a random token.
    def User.new_token
      SecureRandom.urlsafe_base64
    end
    # Remembers a user in the database for use in persistent sessions.
    def remember
      self.remember_token = User.new_token
      update_attribute(:remember_digest, User.digest(remember_token))
    end
    # Returns true if the given token matches the digest.
    def authenticated?(remember_token)
      BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end
    # Forgets a user.
    def forget
      update_attribute(:remember_digest, nil)
    end

    # Returns true if a password reset has expired.
    def password_reset_expired?
      reset_sent_at < 2.hours.ago
    end

    def feed
      following_ids = "SELECT followed_id FROM relationships
                     WHERE  follower_id = :user_id"
      Micropost.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)
    end

    # Follows a user.
    def follow(other_user)
      active_relationships.create(followed_id: other_user.id)
    end

    # Unfollows a user.
    def unfollow(other_user)
      active_relationships.find_by(followed_id: other_user.id).destroy
    end

    # Returns true if the current user is following the other user.
    def following?(other_user)
      following.include?(other_user)
    end

    def collect(micropost)
      collections.create(collected_id: micropost.id)
    end

    def uncollect(micropost)
      collections.find_by(collected_id: micropost.id).destroy
    end

    def collecting?(micropost)
      collecting.include?(micropost)
    end
end
