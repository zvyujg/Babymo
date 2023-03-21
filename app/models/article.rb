class Article < ApplicationRecord
    has_many_attached :images
    validates :user_id, presence: true
    validates :title, presence: true, length: { maximum: 50 }
    validates :content, presence: true, length: { maximum: 400 }
    belongs_to :user
    has_many :favorites, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :article_tags, dependent: :destroy
    has_many :tags, through: :article_tags
    
    # お気に入り真偽
  def favorited?(user)
    favorites.where(user_id: user.id).exists? if favorites.exists?
  end

  # タグの保存
  def save_tags(tags)
    unless tags.nil?
      current_tags = self.tags.pluck(:name)
      # 古いタグの削除
      old_tags = current_tags - tags
      old_tags.each do |old_tag|
        self.tags.delete Tag.find_by(name: old_tag)
      end
      # 新しいタグの追加
      new_tags = tags - current_tags
      new_tags.each do |new_tag|
        article_category = Tag.find_or_create_by(name: new_tag)
        article_category.score = Analyze.get_data(new_tag)
        self.tags << article_category
      end
    end
  end
end
