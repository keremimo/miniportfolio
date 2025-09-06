require "test_helper"

class PostTest < ActiveSupport::TestCase
  test "valid with title and optional content/image" do
    post = Post.new(title: "Hello", text: "Some text")
    post.content = "<div>Hello world</div>"
    assert post.valid?
  end

  test "invalid without title" do
    post = Post.new
    assert_not post.valid?
    assert_includes post.errors.attribute_names, :title
  end

  test "invalid without text" do
    post = Post.new(title: "Hello")
    assert_not post.valid?
    assert_includes post.errors.attribute_names, :text
  end
end
