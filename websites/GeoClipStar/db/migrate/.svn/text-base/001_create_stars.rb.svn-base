class CreateStars < ActiveRecord::Migration
  def self.up
    create_table :stars do |t|
      t.integer :contents_id # コンテンツID
      t.string :title # タイトル
      t.string :subject # 本文
      t.string :tag # タグ
      t.integer :member_id # ユーザーのID
      t.string :author_name # 記事の投稿者名
      t.string :image_url # イメージのURL
      t.float :latitude # 緯度 WGS84、度形式（小数点以下百分率）
      t.float :longitude # 経度 経度　WGS84、度形式（小数点以下百分率）
      t.datetime :create_date # YYYY-MM-DD HH:MM:SS
      t.integer :good_count # GOODカウント数
      t.integer :access_count # アクセスカウント数
      t.timestamps
    end
  end

  def self.down
    drop_table :stars
  end
end
