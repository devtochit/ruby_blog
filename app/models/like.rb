class Like < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  belongs_to :post

  after_save :update_likes_counter
  # A method that updates the likes counter for a post.
  def update_like_counter
    post.increment!(:likes_counter)
  end

  private :update_likes_counter
end
