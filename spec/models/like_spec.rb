require 'rails_helper'

RSpec.describe Like, type: :model do
  subject do
    author = User.new(
      name: 'Mike Patton',
      photo: 'http://www.nacionrock.com/wp-content/uploads/patton-34.jpg',
      bio: 'Singer with one of the widest vocal ranges of all time',
      posts_counter: 0
    )
    post = Post.new(author:,
                    title: 'Title',
                    text: 'Text',
                    comments_counter: 0,
                    likes_counter: 0)
    Like.new(post:, author:)
  end

  before { subject.save }

  #  Test methods
  describe 'update_likes_counter' do
    it 'should update the likes counter' do
      expect(subject.send(:update_likes_counter)).to be_valid
    end
  end
end
