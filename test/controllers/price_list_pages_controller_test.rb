require "test_helper"

class PriceListPagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:admin)
  end

  test "should show price list page" do
    get price_list_url
    assert_response :success
  end

  test "should get edit" do
    sign_in_as(@user)
    get edit_price_list_url
    assert_response :success
  end

  test "should update price list page" do
    sign_in_as(@user)
    patch price_list_url, params: { price_list_page: { title: "Commission Rates", content: "<p>Updated pricing</p>" } }

    assert_redirected_to price_list_url
    page = PriceListPage.fetch
    assert_equal "Commission Rates", page.title
    assert_equal "Updated pricing", page.content.to_plain_text.strip
  end

  private

  def sign_in_as(user)
    post session_path, params: { email_address: user.email_address, password: "password" }
    assert_response :redirect
  end
end
