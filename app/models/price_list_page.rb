class PriceListPage < ApplicationRecord
  SINGLETON_ID = 1
  DEFAULT_CONTENT = "<p>Price list placeholder. Update this page from the admin editor.</p>".freeze

  has_rich_text :content

  validates :title, presence: true

  def self.fetch
    find_by(id: SINGLETON_ID) || create_or_find_by!(id: SINGLETON_ID) do |page|
      page.title = "Price List"
      page.content = DEFAULT_CONTENT
    end
  end
end
