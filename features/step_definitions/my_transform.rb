QUESTION_COUNT = Transform /^\d+$/ do |question_count|
	question_count.to_i
end