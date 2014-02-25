Given(/^A user visits the maths game home page$/) do
  on(HomePage) do |page|
    page.goto
  end	
end

Then(/^I should be able to see options to choose level$/) do
	on(HomePage).image_for_level_easy_element.visible?.should == true
	on(HomePage).image_for_level_medium_element.visible?.should == true
	on(HomePage).image_for_level_hard_element.visible?.should == true
end

And(/^I should be able to see options to choose a game$/) do
	on(HomePage).image_for_add_element.visible?.should == true
	on(HomePage).image_for_subtract_element.visible?.should == true
	on(HomePage).image_for_divide_element.visible?.should == true
	on(HomePage).image_for_multiply_element.visible?.should == true
end

Then(/^he should be able to select level "(.*?)" and game "(.*?)"$/) do |level,game|
	on(HomePage).select_options({:level => level, :game => game})
end

When(/^I select the game level of "(.*?)"$/) do |level|
	on(HomePage).select_level({:level => level})
end

Then(/^there should be only one highlighted level$/) do
	on(HomePage).has_one_highlighted_level?.should == true
end

And(/^I select the game "(.*?)"$/) do |game|
	on(HomePage).select_game({:game => game})
end

Then(/^there should be only one highlighted game$/) do
	on(HomePage).has_one_highlighted_game?.should == true
end

When(/^the user chooses level "(.*?)" with "(.*?)" the page title should be "(.*?)"$/) do |level,game,page_title|
	on(HomePage) do |page|
		page.select_level({:level => level})
		page.select_game({:game => game})
		page.start_game
		page.title.should == page_title
	end
	
end