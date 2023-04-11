require 'application_system_test_case'

class PostsTest < ApplicationSystemTestCase
  setup do
    @user = User.create(
      name: 'Name',
      photo: 'https://avatars.githubusercontent.com/u/114885671?v=4',
      bio: 'I am software developer',
      posts_counter: 1
    )
    @post1 = Post.create(author: @user, title: 'This is a post', text: 'This is the post text', comments_counter: 0,
                         likes_counter: 0)
    @comment1 = Comment.create(post: @post1, author: @user, text: 'This is a comment')
    @comment2 = Comment.create(post: @post1, author: @user, text: 'This is the second comment')
  end

  test 'Can see profile picture of user' do
    visit user_posts_path(@user)
    assert_selector 'img'
  end

  test 'can see the user\'s username.' do
    visit user_posts_path(@user)
    assert_text @user.name
  end

  test 'Can see the number of posts a user has written' do
    visit user_posts_path(@user)
    assert_selector('.post-count')
  end

  test 'can see post title' do
    visit user_posts_path(@user)
    assert_text(@post1.title)
  end

  test 'can see some of the post\'s body.' do
    visit user_posts_path(@user)
    assert_text(@post1.text)
  end

  test 'can see the first comments on a post' do
    visit user_posts_path(@user)
    assert_text(@post1.comments.first.text)
  end

  test ' can see how many comments a post has.' do
    visit user_posts_path(@user)
    assert_text("comments: #{@post1.comments_counter}")
  end

  test ' can see how many likes a post has.' do
    visit user_posts_path(@user)
    assert_text("likes: #{@post1.likes_counter}")
  end

  test 'can see a section for pagination if there are more posts than fit on the view' do
    visit user_posts_path(@user)
    assert_selector :button, 'Pagination'
  end

  test 'clicking on a post, it redirects me to that post\'s show page.' do
    visit user_posts_path(@user)
    click_link(@post1.title)
    assert_current_path(user_post_path(@user, @post1))
  end

  # Post show page
  test 'can see the post\'s title.' do
    visit user_post_path(@user, @post1)
    assert_text @post1.title
  end
  test 'can see who wrote the post' do
    visit user_post_path(@user, @post1)
    assert_text @post1.author.name
  end
  test 'can see how many comments it has' do
    visit user_post_path(@user, @post1)
    assert_text @post1.comments_counter.to_s
  end
  test 'I can see how many likes it has' do
    visit user_post_path(@user, @post1)
    assert_text @post1.likes_counter.to_s
  end
  test 'can see the post body' do
    visit user_post_path(@user, @post1)
    assert_text @post1.text
  end
  test 'can see the username of each commentor' do
    visit user_post_path(@user, @post1)
    assert_text @user.name
  end
  test 'can see the comment each commentor left' do
    visit user_post_path(@user, @post1)
    assert_selector('.single-comment', count: 2)
  end
end
