class CreatePriceListPages < ActiveRecord::Migration[8.0]
  def change
    create_table :price_list_pages do |t|
      t.string :title, null: false

      t.timestamps
    end
  end
end
