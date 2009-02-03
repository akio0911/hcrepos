class AddColumnStarEndFlg < ActiveRecord::Migration
  def self.up
    add_column :stars, :end_flg, :boolean
  end

  def self.down
    remove_column :stars, :end_flg
  end
end
