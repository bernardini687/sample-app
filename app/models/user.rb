class User < ApplicationRecord
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]{1,4}\z/i.freeze

  before_save do
    name.capitalize!
    email.downcase!
  end

  validates :name,  presence: true,
                    length: { maximum: 32 }

  validates :email, presence: true,
                    length: { maximum: 255 },
                    format: { with: EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
end
