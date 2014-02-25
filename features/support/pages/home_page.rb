require 'page-object'

class HomePage
	include PageObject

	page_url 'http://localhost:3000'
	link(:start_again, :id => "start_again")
	link(:score_message, :id => "score_message")
	h3(:level_header, :id => "level_header")
	h3(:game_header, :id => "game_header")

	image(:image_for_level_easy, :name => "easy")
	image(:image_for_level_medium, :name => "medium")
	image(:image_for_level_hard, :name => "hard")

	image(:image_for_add, :name => "add")
	image(:image_for_subtract, :name => "subtract")
	image(:image_for_multiply, :name => "multiply")
	image(:image_for_divide, :name => "divide")

	button(:start_game, :name=>"start_game")

	def select_options(options)
		image_level = ("image_for_level_"+options[:level]+"_element")
		image_game = ("image_for_"+options[:game]+"_element")
		self.send(image_level.to_sym).click()
		self.send(image_game.to_sym).click()
	end

	def has_one_highlighted_level?
		highlighted_levels = 0
		@browser.images(:class => "game_level_image").each do |tag|
		  highlighted_levels += 1 if tag.class_name =~ /selected_option/
		end
		true if highlighted_levels == 1
	end

	def has_one_highlighted_game?
		highlighted_games = 0
		@browser.images(:class => "game_type_image").each do |tag|
		  highlighted_games += 1 if tag.class_name =~ /selected_option/
		end
		true if highlighted_games == 1
	end

	def select_level(options) 
		image_level = ("image_for_level_"+options[:level]+"_element")
		self.send(image_level.to_sym).click()
	end

	def select_game(options) 
		image_game = ("image_for_"+options[:game]+"_element")
		self.send(image_game.to_sym).click()
	end

end