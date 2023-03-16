class Tag < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 20 }
  has_many :articles, dependent: :destroy
  has_many :article_tags, dependent: :destroy
  has_many :articles, through: :article_tags, source: :article

  def self.article_count(tag_name)
    find_by(name: tag_name).articles.size
  end

  def self.tag_ranking(num)
    find(ArticleTag.group(:tag_id).order('count(tag_id) desc').limit(num).pluck(:tag_id))
  end
end
