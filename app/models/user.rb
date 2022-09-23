class User < ApplicationRecord
  validates :name, presence: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  has_many :posts, foreign_key: 'author_id'
  has_many :comments, foreign_key: 'author_id'
  has_many :likes, foreign_key: 'author_id'

  # A method that returns the 3 most recent posts for a given user.

  def find_posts
    Post.where(author: self).order(updated_at: :desc).first(3)
  end

  # posts_counter must be an integer
  after_initialize do |user|
    user.posts_counter = 0
  end
end

