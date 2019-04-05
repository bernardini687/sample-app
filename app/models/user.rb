class User < ApplicationRecord
  validates :name,  presence: true,
                    length: { maximum: 32 }
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]{1,4}\z/i.freeze

  validates :email, presence: true,
                    length: { maximum: 255 },
                    format: { with: EMAIL_REGEX }
end
