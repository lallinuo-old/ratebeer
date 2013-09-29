class DeleteOldStyle < ActiveRecord::Migration
  def up
    remove_column :beers, :old_style
  end

  def down
  end
end
