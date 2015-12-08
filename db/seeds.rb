# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Users table
User.create(name:"liyihan00", email:"116055096800@qq.com", password:"000000", password_confirmation:"000000")
User.create(name:"liyihan01", email:"116055096801@qq.com", password:"010101", password_confirmation:"010101")
User.create(name:"liyihan02", email:"116055096802@qq.com", password:"020202", password_confirmation:"020202")


#Micropost table
user = User.find(1)
user.microposts.create(content:"This is Icecream!", picture:"IceCream.png")
user = User.find(2)
user.microposts.create(content:"This is Apple Chip!", picture:"AppleChip.png")
user = User.find(3)
user.microposts.create(content:"This is Mushroom Soup!", picture:"MushroomSoup.png")

# Following relationships
Relationship.create(follower_id:"2", followed_id:"1")
Relationship.create(follower_id:"3", followed_id:"1")
Relationship.create(follower_id:"1", followed_id:"2")
Relationship.create(follower_id:"1", followed_id:"3")