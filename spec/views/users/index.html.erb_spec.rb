require 'rails_helper'

RSpec.describe 'users #index', type: :feature do

#  before do
    num_users_created = 3
    @fake_users = []

    num_users_created.times do |i|
      user = User.create(
        name: "User Test - #{i}",
        photo: "test#{i}.png",
        bio: "Testing #{i}..."
      )
      @fake_users.push(user)
    end

    visit root_path
  end

  it 'should show the username of each user' do
    @fake_users.each do |user|
      expect(page).to have_content(user.name)
    end
  end

  it 'should show the profile picture for each user' do
    @fake_users.each do |user|
      expect(page).to have_css("img[src='#{user.photo}']")
    end
  end

  it 'should show the number of posts each user has written' do
    num_posts_created = 5

    num_posts_created.times do |i|
      user_index = i % (@fake_users.length - 1)

      Post.create(
        author: @fake_users[user_index],
        title: "Post - #{i}",
        text: "Post description - #{i}"
      )
    end

    visit root_path

    @fake_users.each do |user|
      expect(page).to have_content("Number of posts: #{user.posts_counter}")
    end
  end

  it "should redirects the current user to the selected user's show page, when he clicks on that specific user" do
    @fake_users.each do |user|
      visit root_path

      click_link user.name

      expect(current_path).to eq user_path(user)
    end
  end
end






























