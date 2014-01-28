# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
b1 = Brewery.create name: 'Koff', year:1897
b2 = Brewery.create name: 'Malmgard', year:2001
b3 = Brewery.create name: 'Weihenstephaner', year:1042
b4 = Brewery.create name: 'BrewDog', year:2007

b1.beers.create name: 'Iso 3', style: 'Lager'
b1.beers.create name: 'Karhu', style: 'Lager'
b1.beers.create name: 'Tuplahumala', style: 'Lager'
b2.beers.create name: 'Huvila Pale Ale', style: 'Pale Ale'
b2.beers.create name: 'X Porter', style: 'Porter'
b3.beers.create name: 'Hefezeizen', style: 'Weizen'
b3.beers.create name: 'Helles', style: 'Lager'
b4.beers.create name: 'Hardcore IPA', style: 'IPA'

u1 = User.create username:'Corvus', password:'Salainen', password_confirmation:'Salainen'
u2 = User.create username:'Cage', password:'Nicolas', password_confirmation:'Nicolas'

b4.beers.first.ratings.create score:50, user_id:u1.id
b1.beers.first.ratings.create score:20, user_id:u1.id

b3.beers.first.ratings.create score:30, user_id:u2.id
b2.beers.first.ratings.create score:43, user_id:u2.id

bc1 = BeerClub.create name: 'Makkaratehtaan kittaajat', year:1992, city:'Vantaa'
bc2 = BeerClub.create name: 'Tapiolan Tapsanjuojat', year:1973, city:'Espoo'

bc1.memberships.create user_id:u1.id
bc1.memberships.create user_id:u2.id
bc2.memberships.create user_id:u1.id