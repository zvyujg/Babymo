class Comment < ApplicationRecord
  validates :user_id, presence: true
  validates :article_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  belongs_to :user
  belongs_to :article
  has_many :replies, class_name: "Comment", foreign_key: "reply_to", dependent: :destroy
end
