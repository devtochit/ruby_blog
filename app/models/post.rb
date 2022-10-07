class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes

  scope :by_author, ->(author_id) { where(author_id:) }
  scope :most_recent_ones, -> { order('created_at DESC') }

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_save :update_posts_counter

  def get_most_recent_comments(num = nil)
    comments.most_recent_ones.limit(num)
  end

  private

  def update_posts_counter
    author.increment!(:posts_counter)
  end
end
