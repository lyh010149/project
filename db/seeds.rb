# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Users table
User.create(name:'liyihan00', email:'116055096800@qq.com', password:"000000", password_confirmation:"000000")
User.create(name:'liyihan01', email:'116055096801@qq.com', password:"010101", password_confirmation:"010101")
User.create(name:'liyihan02', email:'116055096802@qq.com', password:"020202", password_confirmation:"020202")
User.create(name:'liyihan03', email:'116055096803@qq.com', password:"030303", password_confirmation:"030303", admin: true)


#Micropost table
user = User.find(1)
user.microposts.create(name:"Icecream", content:"ice, cream, suger")
user = User.find(2)
user.microposts.create(name:"Apple Chip", content:"apple, tomato sause!")
user = User.find(3)
user.microposts.create(name:"Mushroom Soup", content:"mushroom, oil, onion, butter, salt, suger, flour")

#relationship table
user1 = User.find(1)
user2 = User.find(2)
user3 = User.find(3)
user2.follow(user1)
user3.follow(user1)
user1.follow(user2)
user3.follow(user2)
user2.follow(user3)


