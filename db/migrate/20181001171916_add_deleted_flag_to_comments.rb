class AddDeletedFlagToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :deleted, :boolean, null: false, default: false
  end
end
