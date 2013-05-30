class CreatePlayerCaches < ActiveRecord::Migration
  def change
    create_table :player_caches do |t|
      t.text :url
      t.text :response

      t.timestamps
    end
  end
end
