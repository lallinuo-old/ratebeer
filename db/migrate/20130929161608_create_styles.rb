class CreateStyles < ActiveRecord::Migration
  def change
    create_table :styles do |t|
      t.text :desc
      t.string :style

      t.timestamps
    end
  end
end
