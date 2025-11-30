class HomePage < ApplicationRecord
  has_rich_text :content

  validates :title, presence: true

  def self.fetch
    first || create!(title: "Home")
  end
end
