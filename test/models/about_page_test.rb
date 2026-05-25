require "test_helper"

class AboutPageTest < ActiveSupport::TestCase
  test "requires a title" do
    about_page = AboutPage.new

    assert_not about_page.valid?
    assert_includes about_page.errors.attribute_names, :title
  end

  test "fetch returns an existing record when present" do
    existing = AboutPage.create!(title: "Existing About")

    assert_no_changes -> { AboutPage.count } do
      assert_equal existing, AboutPage.fetch
    end
  end

  test "fetch creates a default record when missing" do
    AboutPage.delete_all

    assert_difference -> { AboutPage.count }, +1 do
      page = AboutPage.fetch
      assert_equal "About", page.title
      assert_includes page.content.body.to_html, "Yasmine Elsen"
    end
  end
end
