class Relationship < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'

  # Redundant as of Rails 5:
  validates :follower_id, presence: true
  validates :followed_id, presence: true
end
