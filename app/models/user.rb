class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :name, presence: true, length: { in: 1..30 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :introduction, length: { maximum: 140 }
  has_one_attached :image
  has_many :sns_credentials, dependent: :destroy
  has_many :articles, dependent: :destroy
  has_many :follow_to, class_name: "Relation",
                       foreign_key: "follower_id",
                       dependent: :destroy
  has_many :follow_from, class_name: "Relation",
                         foreign_key: "followed_id",
                         dependent: :destroy
  has_many :following, through: :follow_to, source: :followed
  has_many :followers, through: :follow_from
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_articles, through: :favorites, source: :article
end
