require "test_helper"

class HomePageTest < ActiveSupport::TestCase
  test "requires a title" do
    home_page = HomePage.new

    assert_not home_page.valid?
    assert_includes home_page.errors.attribute_names, :title
  end

  test "fetch returns an existing record when present" do
    existing = HomePage.create!(title: "Existing Home")

    assert_no_changes -> { HomePage.count } do
      assert_equal existing, HomePage.fetch
    end
  end

  test "fetch creates a default record when missing" do
    HomePage.delete_all

    assert_difference -> { HomePage.count }, +1 do
      page = HomePage.fetch
      assert_equal "Home", page.title
    end
  end
end
