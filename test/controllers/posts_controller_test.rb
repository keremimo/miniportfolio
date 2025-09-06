require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
    @user = users(:admin)
  end

  test "should get index" do
    get posts_url
    assert_response :success
  end

  test "should get new" do
    sign_in_as(@user)
    get new_post_url
    assert_response :success
  end

  test "should create post with image and content" do
    sign_in_as(@user)
    file = file_fixture("test.svg")
    assert_difference("Post.count", 1) do
      post posts_url, params: {
        post: {
          title: "Created via test",
          content: "<h1>Body</h1>",
          image: Rack::Test::UploadedFile.new(file, "image/svg+xml")
        }
      }
    end

    created = Post.order(:created_at).last
    assert_redirected_to post_url(created)
    assert created.image.attached?
    assert_equal "Created via test", created.title
  end

  test "should show post" do
    get post_url(@post)
    assert_response :success
  end

  test "should get edit" do
    sign_in_as(@user)
    get edit_post_url(@post)
    assert_response :success
  end

  test "should update post" do
    sign_in_as(@user)
    patch post_url(@post), params: { post: { title: "Updated title" } }
    assert_redirected_to post_url(@post)
    @post.reload
    assert_equal "Updated title", @post.title
  end

  test "should destroy post" do
    sign_in_as(@user)
    assert_difference("Post.count", -1) do
      delete post_url(@post)
    end

    assert_redirected_to posts_url
  end

  private
    def sign_in_as(user)
      post session_path, params: { email_address: user.email_address, password: "password" }
      assert_response :redirect
    end
end
