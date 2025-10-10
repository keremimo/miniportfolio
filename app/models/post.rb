class Post < ApplicationRecord
  validates :title, presence: true
  validates :published_at, presence: true

  before_validation :assign_default_published_at

  has_rich_text :content
  has_one_attached :image

  private

  def assign_default_published_at
    return unless new_record?
    return if published_at.present?

    self.published_at = Time.zone.today
  end
end
