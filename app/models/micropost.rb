class Micropost < ApplicationRecord
  belongs_to :user
  
  validates :content, presence: true, length: { maximum: 255 }
  
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  has_many :comments, dependent: :destroy
  has_many :commenters, through: :comments, source: :user
  
  def self.create_all_ranks
    Micropost.find(Favorite.group(:micropost_id).order('count(micropost_id) desc').limit(5).pluck(:micropost_id))
  end
end
