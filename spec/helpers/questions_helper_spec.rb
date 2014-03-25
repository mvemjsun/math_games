require 'spec_helper'

describe QuestionsHelper do

  #
  # Addition
  #
  context "For addition games" do

  	before(:all) do
  		@game="add"
  	end

  	context "easy level" do

  		before(:each) do
  			@level="easy"
  		end

  		it "should return an addition question" do
  			question = present_question(@game,@level)
  			question[:operator].should == "+"
  			question[:operand1].should be_kind_of(Fixnum)
  			question[:operand2].should be_kind_of(Fixnum)
  		end
  	end

	context "medium level" do

		before(:each) do
			@level="medium"
		end

		it "should return an addition question" do
			question = present_question(@game,@level)
			question[:operator].should == "+"
			question[:operand1].should be_kind_of(Fixnum)
			question[:operand2].should be_kind_of(Fixnum)
		end
	end 

	context "medium level" do

		before(:each) do
			@level="hard"
		end

		it "should return an addition question" do
			question = present_question(@game,@level)
			question[:operator].should == "+"
			question[:operand1].should be_kind_of(Fixnum)
			question[:operand2].should be_kind_of(Fixnum)
		end
	end 

  end 

  #
  # multiply
  #
  context "For multiplication games" do
  	before(:all) do
  		@game="multiply"
  	end

  	context "easy level" do

  		before(:each) do
  			@level="easy"
  		end

  		it "should return an multiplication question" do
  			question = present_question(@game,@level)
  			question[:operator].should == "*"
  			question[:operand1].should be_kind_of(Fixnum)
  			question[:operand2].should be_kind_of(Fixnum)
  		end
  	end

	context "medium level" do

		before(:each) do
			@level="medium"
		end

		it "should return an multiplication question" do
			question = present_question(@game,@level)
			question[:operator].should == "*"
			question[:operand1].should be_kind_of(Fixnum)
			question[:operand2].should be_kind_of(Fixnum)
		end
	end 

	context "medium level" do

		before(:each) do
			@level="hard"
		end

		it "should return an multiplication question" do
			question = present_question(@game,@level)
			question[:operator].should == "*"
			question[:operand1].should be_kind_of(Fixnum)
			question[:operand2].should be_kind_of(Fixnum)
		end
	end 
  end 

  #
  # -- Subtraction
  #
  context "Subtraction" do
	before(:each) do
		@level="hard"
		@game="subtract"
	end

	it "should return an subtraction question" do
		question = present_question(@game,@level)
		question[:operator].should == "-"
		question[:operand1].should be_kind_of(Fixnum)
		question[:operand2].should be_kind_of(Fixnum)
	end

	it "Operand1 should be greater than operand2" do
		question = present_question(@game,@level)
		question[:operand1].should be >= question[:operand2]
	end
  end

  context "Division" do
	before(:each) do
		@level="hard"
		@game="divide"
	end

	it "should return an division question" do
		question = present_question(@game,@level)
		question[:operator].should == "/"
		question[:operand1].should be_kind_of(Fixnum)
		question[:operand2].should be_kind_of(Fixnum)
	end

	it "Should not divide by 0" do
		question = present_question(@game,@level)
		question[:operand2].should be > 0
	end	
  end

end
