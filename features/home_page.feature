
Feature: Home page. The home page presents the user with the options for the math games. The options allow the user to select a game level (easy, medium and hard) and select the type of math game. Currently there are 4 games to choose from.

Background:
Given A user visits the maths game home page

Scenario: Be able to see game options
	Then I should be able to see options to choose level
	And I should be able to see options to choose a game

Scenario Outline: Be able to select various game options
	Then he should be able to select level "<game_level>" and game "<game_name>"

	Examples:
	| game_level | game_name |
	| easy       | add       |
	| easy       | subtract  |
	| easy       | multiply  |
	| easy       | divide    |

Scenario: User should be able to select one game level
	And I select the game level of "easy"
	And I select the game level of "medium"
	And I select the game level of "hard"
	Then there should be only one highlighted level
	
Scenario: User should be able to select one game type
	And I select the game "add"
	And I select the game "subtract"
	And I select the game "multiply"
	And I select the game "divide"
	Then there should be only one highlighted game
@current
Scenario Outline: Starting various game options
	When the user chooses level "<game_level>" with "<game_name>" the page title should be "<expected_page_title>"

	Examples:
	| game_level | game_name | expected_page_title          |
	| easy       | add       | Playing easy add             |
	| medium     | add       | Playing medium add           |
	| hard       | add       | Playing hard add             |
	| easy       | subtract  | Playing easy subtract        |
	| medium     | subtract  | Playing medium subtract      |
	| hard       | subtract  | Playing hard subtract        |
	| easy       | divide    | Playing easy divide          |
	| medium     | divide    | Playing medium divide        |
	| hard       | divide    | Playing hard divide          |
	| easy       | multiply  | Playing easy multiply        |
	| medium     | multiply  | Playing medium multiply      |
	| hard       | multiply  | Playing hard multiply        |	