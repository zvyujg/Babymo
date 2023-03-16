class ArticleTag < ApplicationRecord
  validates :article_id, presence: true
  validates :tag_id, presence: true
  belongs_to :article
  belongs_to :tag
end
