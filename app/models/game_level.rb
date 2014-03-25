class GameLevel < ActiveRecord::Base
  attr_accessible :level

  has_many :games
end
