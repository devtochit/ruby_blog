require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    User.new(
      name: 'Mike Patton',
      photo: 'http://www.nacionrock.com/wp-content/uploads/patton-34.jpg',
      bio: 'Singer with one of the widest vocal ranges of all time',
      posts_counter: 0
    )
  end

  before { subject.save }

  # Test validators
  describe 'name' do
    it 'should not be valid if the name is blank' do
      subject.name = nil
      expect(subject).to_not be_valid
    end
  end
  describe 'posts_counter' do
    it 'should be an integer' do
      expect(subject.posts_counter).to be_an_integer
    end
    it 'should be greater than or equal to 0' do
      expect(subject.posts_counter).to be >= 0
      expect(subject.posts_counter).to_not be < 0
    end
  end
  #   Test methods
  describe 'find_posts' do
    it 'should return 3 posts' do
      subject.posts.create(title: '1', text: 'text', comments_counter: 0, likes_counter: 0)
      subject.posts.create(title: '2', text: 'text', comments_counter: 0, likes_counter: 0)
      subject.posts.create(title: '3', text: 'text', comments_counter: 0, likes_counter: 0)
      subject.posts.create(title: '4', text: 'text', comments_counter: 0, likes_counter: 0)
      subject.posts.create(title: '5', text: 'text', comments_counter: 0, likes_counter: 0)
      subject.posts.create(title: '6', text: 'text', comments_counter: 0, likes_counter: 0)

      expect(subject.find_posts.count).to be(3)
    end
  end
end
