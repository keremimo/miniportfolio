require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
  end

  test "should get index" do
    get posts_url
    assert_response :success
  end

  test "should get new" do
    get new_post_url
    assert_response :success
  end

  test "should create post with image and content" do
    file = file_fixture("test.svg")
    assert_difference("Post.count", 1) do
      post posts_url, params: {
        post: {
          title: "Created via test",
          text: "Created via test text",
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
    get edit_post_url(@post)
    assert_response :success
  end

  test "should update post" do
    patch post_url(@post), params: { post: { title: "Updated title", text: "Updated text" } }
    assert_redirected_to post_url(@post)
    @post.reload
    assert_equal "Updated title", @post.title
    assert_equal "Updated text", @post.text
  end

  test "should destroy post" do
    assert_difference("Post.count", -1) do
      delete post_url(@post)
    end

    assert_redirected_to posts_url
  end
end
