# create Games table
class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.integer 'object_id', null: false
      t.text  'name', null: false
      t.string  'object_type', null: false, limit: 20
      t.integer :min_players
      t.integer :max_players
      t.integer :min_age
      t.integer :play_time
      t.integer :max_playtime
      t.integer :min_playtime
      t.text    :description
    end
  end
end
