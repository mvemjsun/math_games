# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
#
# User seed
p "Creating User data"
1.times do |count|
    user = User.new
    user.email = "user#{count}@example.com"
    user.password = "password1234"
    user.name = "Mr User number #{count}"
    if user.save
        p "User #{count} created"
    else
        p user.errors
    end
end


["easy","medium","hard"].each do |level|
    l = GameLevel.new
    l.level = level
    l.save
end


["add","subtract","multiply","divide"].each do |game|
    g = GameName.new
    g.name = game
    g.save
end