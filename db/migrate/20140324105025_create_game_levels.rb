class CreateGameLevels < ActiveRecord::Migration
  def change
    create_table :game_levels do |t|
      t.string :level

      t.timestamps
    end
  end
end
