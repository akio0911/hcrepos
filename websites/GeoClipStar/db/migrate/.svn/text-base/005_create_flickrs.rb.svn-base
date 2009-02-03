class CreateFlickrs < ActiveRecord::Migration
  def self.up
    create_table :flickrs do |t|
      t.string :value, :link , :pub_date
      t.text :description
      t.timestamps
    end
  end

  def self.down
    drop_table :flickrs
  end
end
