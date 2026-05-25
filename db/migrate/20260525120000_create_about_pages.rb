class CreateAboutPages < ActiveRecord::Migration[8.0]
  def change
    create_table :about_pages do |t|
      t.string :title, null: false

      t.timestamps
    end
  end
end
