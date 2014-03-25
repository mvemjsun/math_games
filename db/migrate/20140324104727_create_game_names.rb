class CreateGameNames < ActiveRecord::Migration
  def change
    create_table :game_names do |t|
      t.string :name

      t.timestamps
    end
  end
end
