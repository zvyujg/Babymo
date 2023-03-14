class Relation < ApplicationRecord
  belongs_to :user
  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'

  validates :user_id, presence: true
  validates :follower_id, presence: true
  validates :followed_id, presence: true
end
