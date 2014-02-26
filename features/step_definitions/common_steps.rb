Then(/^I should see message "(.*?)"$/) do |message|
	@browser.text.include?(message).should == true
end