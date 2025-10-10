class AddPublishedAtToPosts < ActiveRecord::Migration[8.0]
  def up
    add_column :posts, :published_at, :datetime, precision: 6, null: false, default: -> { "CURRENT_TIMESTAMP" }

    execute <<~SQL
      UPDATE posts
      SET published_at = created_at
    SQL
  end

  def down
    remove_column :posts, :published_at
  end
end
