class CreateHomePages < ActiveRecord::Migration[8.0]
  def change
    create_table :home_pages do |t|
      t.string :title, null: false

      t.timestamps
    end
  end
end
