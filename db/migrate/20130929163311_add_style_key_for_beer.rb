class AddStyleKeyForBeer < ActiveRecord::Migration
  def up
    add_column :beers, :style_id, :integer
  end

  def down
  end
end
