class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :user_id
      t.integer :subject_id
      t.integer :level_id
      t.integer :qpresented
      t.integer :qanswered
      t.integer :qskipped
      t.date :gamedate
      t.string :status

      t.timestamps
    end

    add_index :games, :user_id
  end
end