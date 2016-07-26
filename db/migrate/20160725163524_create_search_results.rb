class CreateSearchResults < ActiveRecord::Migration[5.0]
  def change
    create_table :search_results do |t|
      t.string :key_word, null: false
      t.integer :user_id, null: false
      t.integer :top_ad_count, null: false, default: 0
      t.integer :bottom_ad_count, null: false, default: 0
      t.integer :result_count, null: false, default: 0
      t.integer :links_count, null: false, default: 0
      t.integer :search_count, null: false, default: 0
      t.text :html_code, null: false

      t.string :url
      t.timestamps
    end
    add_foreign_key :search_results, :users
  end
end
