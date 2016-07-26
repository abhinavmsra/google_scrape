class AddWorkerIpToSearchResults < ActiveRecord::Migration[5.0]
  def change
    add_column :search_results, :worker_ip, :string
  end
end
