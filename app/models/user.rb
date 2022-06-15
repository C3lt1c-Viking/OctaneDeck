class User < ApplicationRecord

  attr_accessor :remember_token, :activation_token, :reset_token
  before_save   :downcase_email
  before_create :create_activation_digest

  has_many :microposts, dependent: :destroy

  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy

  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy

  has_many :following, through: :active_relationships,  source: :followed

  has_many :followers, through: :passive_relationships, source: :follower

  has_one_attached :avatar

  has_one_attached :banner

  attr_accessor :remember_token

  before_save { email.downcase! }

  validates :first_name, presence: true, length: { maximum: 50 }, allow_nil: true, presence: false

  validates :last_name, presence: true, length: { maximum: 50 }, allow_nil: true, presence: false

  validates :username, presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: true

  validates :hobbies, presence: true, length: { maximum: 1000 }, allow_nil: true, presence: false

  validates :job_title, presence: true, length: { maximum: 65 }, allow_nil: true, presence: false

  validates :job_company, presence: true, length: { maximum: 65 }, allow_nil: true, presence: false

  validates :highest_education, presence: true, length: { maximum: 100 }, allow_nil: true, presence: false

  validates :crypto_wallet_1, presence: true, length: { maximum: 100 }, allow_nil: true, presence: false

  validates :crypto_wallet_2, presence: true, length: { maximum: 100 }, allow_nil: true, presence: false

  validates :crypto_wallet_3, presence: true, length: { maximum: 100 }, allow_nil: true, presence: false

  validates :facebook, presence: true, length: { maximum: 70 }, allow_nil: true, presence: false

  validates :twitter, presence: true, length: { maximum: 70 }, allow_nil: true, presence: false

  validates :github, presence: true, length: { maximum: 70 }, allow_nil: true, presence: false

  validates :stackoverflow, presence: true, length: { maximum: 70 }, allow_nil: true, presence: false

  validates :other_site, presence: true, length: { maximum: 70 }, allow_nil: true, presence: false

  validates :cell, presence: true, length: { maximum: 20 }, allow_nil: true, presence: false

  validates :marital_status, presence: true, length: { maximum: 30 }, allow_nil: true, presence: false

  validates :sex, presence: true, length: { maximum: 20 }, allow_nil: true, presence: false

  validates :interested_in, presence: true, length: { maximum: 100 }, allow_nil: true, presence: false

  has_secure_password

  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  # Returns the hash digest of the given string.
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
    remember_digest
  end

  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Returns a session token to prevent session hijacking.
  # We reuse the remember digest for convenience.
  def session_token
    remember_digest || remember
  end

  # Returns a user's status feed.
  def feed
    following_ids = "SELECT followed_id FROM relationships
                     WHERE  follower_id = :user_id"
    Micropost.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)
             .includes(:user, image_attachment: :blob)
  end

  # Follows a user.
  def follow(other_user)
    following << other_user unless self == other_user
  end

  # Unfollows a user.
  def unfollow(other_user)
    following.delete(other_user)
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end

  # Activates an account.
  def activate
    update_attribute(:activated,    true)
    update_attribute(:activated_at, Time.zone.now)
  end

  # Sends activation email.
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end


  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end


    # Returns true if a password reset has expired.
    def password_reset_expired?
      reset_sent_at < 2.hours.ago
    end

    private

      # Converts email to all lowercase.
      def downcase_email
        self.email = email.downcase
      end

      # Creates and assigns the activation token and digest.
      def create_activation_digest
        self.activation_token  = User.new_token
        self.activation_digest = User.digest(activation_token)
      end


end
