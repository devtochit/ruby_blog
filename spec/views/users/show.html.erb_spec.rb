require 'rails_helper'

RSpec.describe 'users #show', type: :feature do
  before(:each) do
    @fake_user = User.create(
      name: 'Mr.Test',
      photo: 'test.png',
      bio: 'Testing...'
    )

    visit user_path(@fake_user)
  end

  it "should show the user's profile picture" do
    expect(page).to have_css("img[src='#{@fake_user.photo}']")
  end

  it "should show the user's username" do
    expect(page).to have_content(@fake_user.name)
  end

  it 'should show the number of posts the user owns' do
    expect(page).to have_content("#{@fake_user.posts_counter} posts")
  end

  it "should show the user's bio" do
    expect(page).to have_content(@fake_user.bio)
  end

  it 'should show a message when he user has no posts created' do
    expect(page).to have_content('No posts created')
  end

  it "should show the user's 3 most recent posts" do
    num_posts_allowed = 3
    num_posts_created = 5
    num_posts_hidden = num_posts_created - num_posts_allowed
    posts = []

    num_posts_created.times do |i|
      post = Post.create(
        author: @fake_user,
        title: "Post - #{i}",
        text: "Post description test - #{i}"
      )
      posts.push(post)
    end

    visit user_path(@fake_user)

    posts[0...num_posts_hidden].each do |post|
      expect(page).not_to have_content(post.title)
    end

    posts[num_posts_hidden..].each do |post|
      expect(page).to have_content(post.title)
    end
  end

  it "should show just the first 100 characters of the user posts' bodies" do
    post = Post.create(
      author: @fake_user,
      title: 'Fake Post',
      text: "Fake description #{'bla' * 100}"
    )

    visit user_path(@fake_user)

    expect(page).to have_content("#{post.text[0..100]}...")
  end

  it 'should redirects the user to the selected post show page, when he clicks on that specific post' do
    post = Post.create(
      author: @fake_user,
      title: 'Fake Post',
      text: 'Fake description '
    )

    visit user_path(@fake_user)

    click_link post.title

    expect(current_path).to eq user_post_path(@fake_user, post)
  end

  it "should redirects the user to the selected posts index page, when he clicks on the 'see all posts button'" do
    Post.create(
      author: @fake_user,
      title: 'Fake Post',
      text: 'Fake description '
    )

    visit user_path(@fake_user)

    click_link 'See All Posts'

    expect(current_path).to eq user_posts_path(@fake_user)
  end
end
