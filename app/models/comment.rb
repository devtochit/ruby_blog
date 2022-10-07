class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  scope :by_post, ->(post_id) { where(post_id:) }
  scope :most_recent_ones, -> { order('created_at DESC') }

  after_save :update_comments_counter

  private

  def update_comments_counter
    post.increment!(:comments_counter)
  end
end
