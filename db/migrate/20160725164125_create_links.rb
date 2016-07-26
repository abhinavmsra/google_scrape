class CreateLinks < ActiveRecord::Migration[5.0]
  def change
    create_table :links do |t|
      t.integer :type, null: false
      t.text :url, null: false
      t.integer :search_result_id, null: false

      t.timestamps
    end
    add_foreign_key :links, :search_results
  end
end
