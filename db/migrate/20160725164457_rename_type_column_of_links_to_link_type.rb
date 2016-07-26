class RenameTypeColumnOfLinksToLinkType < ActiveRecord::Migration[5.0]
  def change
    rename_column :links, :type, :link_type
  end
end
