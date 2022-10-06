require 'rails_helper'

RSpec.describe 'users #index', type: :feature do
  before(:each) do
    @fake_user = User.create(
      name: 'Mr.Test',
      photo: 'test.png',
      bio: 'Testing...'
    )
    @fake_post = Post.create(
      author: @fake_user,
      title: 'Fake Post',
      text: 'Fake description'
    )

    visit user_post_path(@fake_user, @fake_post)
  end

  it "should show the post's title" do
    expect(page).to have_content(@fake_post.title)
  end

  it 'should show who wrote the post' do
    expect(page).to have_content(@fake_user.name)
  end

  it 'should show how many comments a post has' do
    expect(page).to have_content("#{@fake_post.comments_counter} comments")
  end

  it 'should show how many likes a post has' do
    expect(page).to have_content("#{@fake_post.likes_counter} likes")
  end

  it "should show the post's body" do
    expect(page).to have_content(@fake_post.text)
  end

  it 'should show the username and picture of each commentor' do
    num_comments_created = 3
    comments = []

    num_comments_created.times do |i|
      comment = Comment.create(
        author: @fake_user,
        post: @fake_post,
        text: "This is the comment example number #{i}"
      )
      comments.push(comment)
    end

    visit user_post_path(@fake_user, @fake_post)

    comments.each do |comment|
      author = comment.author

      expect(page).to have_content(author.name)
      expect(page).to have_css("img[src='#{author.photo}']")
    end
  end

  it 'should show the comment each commentor left' do
    num_comments_created = 3
    comments = []

    num_comments_created.times do |i|
      comment = Comment.create(
        author: @fake_user,
        post: @fake_post,
        text: "This is the comment example number #{i}"
      )
      comments.push(comment)
    end

    visit user_post_path(@fake_user, @fake_post)

    comments.each do |comment|
      expect(page).to have_content(comment.text)
    end
  end
end
