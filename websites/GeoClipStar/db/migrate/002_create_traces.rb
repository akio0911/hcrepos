class CreateTraces < ActiveRecord::Migration
  def self.up
    create_table :traces do |t|
      t.integer :location_id # ロケーションＩＤ
      t.float :latitude # 緯度　WGS84、度形式（小数点以下百分率）
      t.float :longitude # 経度　WGS84、度形式（小数点以下百分率）
      t.float :altitude # 高度　メートルm (参考値)※既存投稿のコンテンツには有りません。
      t.datetime :log_date # YYYY-MM-DD HH:MM:SS 位置情報取得日時
      t.datetime :create_date # YYYY-MM-DD HH:MM:SS ジオクリ格納日時
      t.timestamps
    end
  end

  def self.down
    drop_table :traces
  end
end
