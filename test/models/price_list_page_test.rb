require "test_helper"

class PriceListPageTest < ActiveSupport::TestCase
  test "requires a title" do
    price_list_page = PriceListPage.new

    assert_not price_list_page.valid?
    assert_includes price_list_page.errors.attribute_names, :title
  end

  test "fetch returns an existing record when present" do
    existing = PriceListPage.create!(id: PriceListPage::SINGLETON_ID, title: "Existing Price List")

    assert_no_changes -> { PriceListPage.count } do
      assert_equal existing, PriceListPage.fetch
    end
  end

  test "fetch creates a default record when missing" do
    PriceListPage.delete_all

    assert_difference -> { PriceListPage.count }, +1 do
      page = PriceListPage.fetch
      assert_equal PriceListPage::SINGLETON_ID, page.id
      assert_equal "Price List", page.title
      assert_equal "Price list placeholder. Update this page from the admin editor.", page.content.to_plain_text.strip
    end
  end
end
