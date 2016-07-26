class RemoveColumnsFromSearchResults < ActiveRecord::Migration[5.0]
  def change
    remove_column :search_results, :top_ad_count
    remove_column :search_results, :bottom_ad_count
    remove_column :search_results, :result_count
  end
end
