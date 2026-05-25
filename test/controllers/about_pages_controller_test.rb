require "test_helper"

class AboutPagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:admin)
  end

  test "should get show" do
    get about_url

    assert_response :success
    assert_select "h1", "About"
  end

  test "should redirect edit when unauthenticated" do
    get edit_about_url

    assert_redirected_to login_url
  end

  test "should get edit" do
    sign_in_as(@user)

    get edit_about_url

    assert_response :success
  end

  test "should update about page" do
    sign_in_as(@user)
    about_page = AboutPage.fetch

    patch about_url, params: {
      about_page: {
        title: "Updated About",
        content: "<p>Updated body</p>"
      }
    }

    assert_redirected_to about_url
    about_page.reload
    assert_equal "Updated About", about_page.title
    assert_includes about_page.content.body.to_html, "Updated body"
  end

  private
    def sign_in_as(user)
      post session_path, params: { email_address: user.email_address, password: "password" }
      assert_response :redirect
    end
end
