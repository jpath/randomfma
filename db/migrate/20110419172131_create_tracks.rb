class CreateTracks < ActiveRecord::Migration
  def self.up
    create_table :tracks do |t|
      t.string :title
      t.string :artist
      t.string :url
      t.string :album
      t.string :curator
      t.string :fma_id
      t.timestamps
    end
  end

  def self.down
    drop_table :tracks
  end
end
