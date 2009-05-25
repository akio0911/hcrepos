class CreateTwitters < ActiveRecord::Migration
  def self.up
    create_table :twitters do |t|
      t.string :value, :link , :pub_date
      t.timestamps
    end
    add_index :twitters, :link
    add_index :twitters, :pub_date
  end

  def self.down
    drop_table :twitters
  end
end
