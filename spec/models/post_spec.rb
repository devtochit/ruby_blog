require 'rails_helper'

RSpec.describe Post, type: :model do
  subject do
    author = User.new(
      name: 'Mike Patton',
      photo: 'http://www.nacionrock.com/wp-content/uploads/patton-34.jpg',
      bio: 'Singer with one of the widest vocal ranges of all time',
      posts_counter: 0
    )
    Post.new(author:,
             title: 'Title',
             text: 'Text',
             comments_counter: 0,
             likes_counter: 0)
  end

  before { subject.save }

  # Test validators
  describe 'title' do
    it 'should not be valid if the title is blank' do
      subject.title = nil
      expect(subject).to_not be_valid
    end
    it 'should not exceed 250 chars' do
      expect(subject.title.length).to be < 250
    end
  end
  describe 'comments_counter' do
    it 'should be an integer' do
      expect(subject.comments_counter).to be_an_integer
    end
    it 'should be greater than or equal to 0' do
      expect(subject.comments_counter).to be >= 0
      expect(subject.comments_counter).to_not be < 0
    end
  end
  describe 'likes_counter' do
    it 'should be an integer' do
      expect(subject.likes_counter).to be_an_integer
    end
    it 'should be greater than or equal to 0' do
      expect(subject.likes_counter).to be >= 0
      expect(subject.likes_counter).to_not be < 0
    end
  end
  #   Test methods
  describe 'find_comments' do
    it 'should return 5 comments' do
      subject.comments.create(text: '1', author: subject.author)
      subject.comments.create(text: '2', author: subject.author)
      subject.comments.create(text: '3', author: subject.author)
      subject.comments.create(text: '4', author: subject.author)
      subject.comments.create(text: '5', author: subject.author)
      subject.comments.create(text: '6', author: subject.author)

      expect(subject.find_comments.count).to be(5)
    end
  end
  describe 'update_posts_counter' do
    it 'should update the posts counter' do
      expect(subject.send(:update_posts_counter)).to be_valid
    end
  end
end
