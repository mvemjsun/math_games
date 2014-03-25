class Game < ActiveRecord::Base
  attr_accessible :gamedate, :game_level_id, :game_name_id,:qanswered, :qpresented, :qskipped, :status, :user_id

  validates :gamedate, presence: true
  validates :status, presence: true
  validates :game_name_id, presence: true
  validates :game_level_id, presence: true
  validates :user_id, presence: true
  validates :status,
	inclusion: { in: %w(S E),  message: "%{value} is not a valid value for game status.", allow_nil: false  }

  belongs_to :user
  belongs_to :game_level
  belongs_to :game_name

  def Game.start_and_create(options)
  	game = Game.new
  	game.gamedate = Time.now
  	game.game_level_id = GameLevel.find_by_level(options[:game_level]).id
  	game.game_name_id = GameName.find_by_name(options[:game_name]).id
  	game.user_id = options[:user_id]
  	game.qanswered = 0
  	game.qpresented = 0
  	game.qskipped = 0
  	game.status = "S"
  	game if game.save
  end

  #
  # refresh the game stats for an started game that has not ended
  #
  def refresh_game_data(options)
  	unless self.status == "E"
	  	if options.has_key? :qpresented
	  		self.qpresented += 1 if options[:qpresented]
	  	end

	  	if options.has_key? :qskipped
	  		self.qskipped += 1 if options[:qskipped]
	  	elsif options.has_key? :qanswered
	  		self.qanswered += 1 if options[:qanswered]
	  	end

	  	if options.has_key? :status
	  		self.status = "E" if options[:status] == :end
	  		self.status = "S" if options[:status] == :start
	  	end
	  	save
  	end
  end

  def Game.questions_asked_so_far(user)
    u = User.find(user)
    add_count = u.games.where(:game_name_id => GameName.find_by_name("add").id).sum(:qpresented)
    divide_count = u.games.where(:game_name_id => GameName.find_by_name("divide").id).sum(:qpresented)
    multiply_count = u.games.where(:game_name_id => GameName.find_by_name("multiply").id).sum(:qpresented)
    subtract_count = u.games.where(:game_name_id => GameName.find_by_name("subtract").id).sum(:qpresented)
    [add_count,divide_count,multiply_count,subtract_count]
  end

  def Game.questions_answered_so_far(user)
    u = User.find(user)
    add_count = u.games.where(:game_name_id => GameName.find_by_name("add").id).sum(:qanswered)
    divide_count = u.games.where(:game_name_id => GameName.find_by_name("divide").id).sum(:qanswered)
    multiply_count = u.games.where(:game_name_id => GameName.find_by_name("multiply").id).sum(:qanswered)
    subtract_count = u.games.where(:game_name_id => GameName.find_by_name("subtract").id).sum(:qanswered)
    [add_count,divide_count,multiply_count,subtract_count]
  end

  #
  # questions asked on a date for a game level date and question count type
  # order [easy, hard, medium]
  def Game.questions_on_date(options)

    u = User.find(options[:user])
    game_id = GameName.find_by_name(options[:game_name].to_s).id
    level_e_id = GameLevel.find_by_level("easy").id
    level_m_id = GameLevel.find_by_level("medium").id
    level_h_id = GameLevel.find_by_level("hard").id

    game_played_on = options[:date].split(/\D/)
    start_date_time = Time.new(game_played_on[0],game_played_on[1],game_played_on[2]).beginning_of_day
    end_date_time = Time.new(game_played_on[0],game_played_on[1],game_played_on[2]).end_of_day

    begin
      q_easy = u.games.where(:game_name_id => game_id, :game_level_id => level_e_id, :gamedate => start_date_time..end_date_time).sum(options[:question])
    rescue ActiveRecord::RecordNotFound => e
      q_easy = 0
    end

    begin
      q_medium = u.games.where(:game_name_id => game_id, :game_level_id => level_m_id, :gamedate => start_date_time..end_date_time).sum(options[:question])
    rescue ActiveRecord::RecordNotFound => e
      q_medium = 0
    end

    begin
      q_hard = u.games.where(:game_name_id => game_id, :game_level_id => level_h_id, :gamedate => start_date_time..end_date_time).sum(options[:question])
    rescue ActiveRecord::RecordNotFound => e
      q_hard = 0
    end    

    [q_easy,q_hard,q_medium]
  end

end
