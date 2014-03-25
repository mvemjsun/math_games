class CorrectGameAttributes < ActiveRecord::Migration
  def up
  	add_column :games, :game_level_id, :integer
  	add_column :games, :game_name_id, :integer
  	remove_column :games, :level_id, :integer
	remove_column :games, :subject_id, :integer  	
  end

  def down
  	remove_column :games, :game_level_id, :integer
  	remove_column :games, :game_name_id, :integer
  	add_column :games, :level_id, :integer
	add_column :games, :subject_id, :integer  	  	
  end
end
