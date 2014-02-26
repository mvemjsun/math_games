Feature: Question page. On the question page the user is presented with a question that is relevant to the chosen level and game. There are options to Skip a question, get the next question and finish the game. Scores are displayed on the top right hand corner. The answer input area senses the answer to change the background colour (red or green)  indicating if the answer is right or wrong. The user can correct the answer to get a green background or skip/get the next question. Each time the user skips or gets a next question his presented question count is incremented.

Background:
Given A user visits the maths game home page

Scenario: Easy addition games
	Then I select the game level of "easy"
	And I select the game "add"
	When I start the game
	And I enter a "right" answer
	Then the answer box should turn "green"
	When I enter a "wrong" answer
	Then the answer box should turn "red"

Scenario: Medium multiply games
	And I select the game level of "medium"
	And I select the game "multiply"
	Then I start the game
	When I enter a "right" answer
	Then the answer box should turn "green"
	When I enter a "wrong" answer
	Then the answer box should turn "red"	

Scenario: Hard division games
	And I select the game level of "hard"
	And I select the game "divide"
	Then I start the game
	When I enter a "right" answer
	Then the answer box should turn "green"
	When I enter a "wrong" answer
	Then the answer box should turn "red"	

Scenario: Hard subtraction games
	And I select the game level of "hard"
	And I select the game "subtract"
	Then I start the game
	When I enter a "right" answer
	Then the answer box should turn "green"
	When I enter a "wrong" answer
	Then the answer box should turn "red"

Scenario: Score all correct answers
	And I select the game level of "medium"
	And I select the game "multiply"
	When I start the game
	And I answer "3" out of "3" questions
	Then I should see message "You scored 3 out of 3."

Scenario: Score some wrong answers in divide
	And I select the game level of "medium"
	And I select the game "divide"
	When I start the game
	And I answer "2" wrong out of "3" questions
	Then I should see message "You scored 1 out of 3."	

Scenario: Score some wrong answers in subtraction
	And I select the game level of "hard"
	And I select the game "subtract"
	When I start the game
	And I answer "1" wrong out of "5" questions
	Then I should see message "You scored 4 out of 5."

@current
Scenario: Skip some questions and check score
	And I select the game level of "hard"
	And I select the game "subtract"
	When I start the game
	And I answer "3" questions and skip "3" questions
	Then I should see message "Score 3 out of 7"