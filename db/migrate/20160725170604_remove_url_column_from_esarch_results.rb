class RemoveUrlColumnFromEsarchResults < ActiveRecord::Migration[5.0]
  def change
    remove_column :search_results, :url
  end
end
