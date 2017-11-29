# Index objectids to prevent duplicates
class AddObjectIdIndexToGames < ActiveRecord::Migration[5.1]
  def change
    add_index :games, :object_id, unique: true
  end
end
