class Post < ApplicationRecord
  validates :title, presence: true
  validates :text, presence: true

  has_rich_text :content
  has_one_attached :image
end
