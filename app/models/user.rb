class User < ApplicationRecord
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]{1,4}\z/i.freeze

  before_save do
    self.name = name.titlecase
    email.downcase!
  end

  validates :name,  presence: true, length: { maximum: 32 }
  validates :email, presence: true,
                    length: { maximum: 255 },
                    format: { with: EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  # Returns the hash digest of the given string.
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
