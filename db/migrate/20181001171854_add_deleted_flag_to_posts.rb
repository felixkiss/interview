class AddDeletedFlagToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :deleted, :boolean, null: false, default: false
  end
end
