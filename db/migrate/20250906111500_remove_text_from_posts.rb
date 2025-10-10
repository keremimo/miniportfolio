class RemoveTextFromPosts < ActiveRecord::Migration[8.0]
  def change
    remove_column :posts, :text, :string
  end
end
