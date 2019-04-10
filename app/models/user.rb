class User < ApplicationRecord
  attr_accessor :remember_token

  before_save do
    self.name = name.titlecase
    email.downcase!
  end

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]{1,4}\z/i.freeze
  validates :name,  presence: true, length: { maximum: 32 }
  validates :email, presence: true,
                    length: { maximum: 255 },
                    format: { with: EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  class << self
    # Returns the hash digest of the given string.
    def digest(string)
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create(string, cost: cost)
    end

    # Returns a random token.
    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
end
