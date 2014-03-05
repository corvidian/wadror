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

s1 = Style.create name: 'Euro Pale Lager', description: 'Similar to the Munich Helles story, many European countries reacted to the popularity of early pale lagers by brewing their own. Hop flavor is significant and of noble varieties, bitterness is moderate, and both are backed by a solid malt body and sweetish notes from an all-malt base.'
s2 = Style.create name: 'English Pale Ale', description: 'The English Pale Ale can be traced back to the city of Burton-upon-Trent, a city with an abundance of rich hard water. This hard water helps with the clarity as well as enhancing the hop bitterness. This ale can be from golden to reddish amber in color with generally a good head retention. A mix of fruity, hoppy, earthy, buttery and malty aromas and flavors can be found. Typically all ingredients are English.'
s3 = Style.create name: 'Baltic Porter', description: "Porters of the late 1700's were quite strong compared to todays standards, easily surpassing 7% alcohol by volume. Some brewers made a stronger, more robust version, to be shipped across the North Sea, dubbed a Baltic Porter. In general, the styles dark brown color covered up cloudiness and the smoky/roasted brown malts and bitter tastes masked brewing imperfections. The addition of stale ale also lent a pleasant acidic flavor to the style, which made it quite popular. These issues were quite important given that most breweries were getting away from pub brewing and opening up breweries that could ship beer across the world."
s4 = Style.create name: 'Hefeweizen', description: 'A south German style of wheat beer (weissbier) made with a typical ratio of 50:50, or even higher, wheat. A yeast that produces a unique phenolic flavors of banana and cloves with an often dry and tart edge, some spiciness, bubblegum or notes of apples. Little hop bitterness, and a moderate level of alcohol. The "Hefe" prefix means "with yeast", hence the beers unfiltered and cloudy appearance. Poured into a traditional Weizen glass, the Hefeweizen can be one sexy looking beer.'
s5 = Style.create name: 'Double IPA', description: 'Take an India Pale Ale and feed it steroids, ergo the term Double IPA. Although open to the same interpretation as its sister styles, you should expect something robust, malty, alcoholic and with a hop profile that might rip your tongue out. The Imperial usage comes from Russian Imperial stout, a style of strong stout originally brewed in England for the Russian Imperial Court of the late 1700s; though Double IPA is often the preferred name.'

b1.beers.create name: 'Iso 3', style_id: s1.id
b1.beers.create name: 'Karhu', style_id: s1.id
b1.beers.create name: 'Tuplahumala', style_id: s1.id
b2.beers.create name: 'Huvila Pale Ale', style_id: s2.id
b2.beers.create name: 'Huvila X Porter', style_id: s3.id
b3.beers.create name: 'Hefeweissbier', style_id: s4.id
b4.beers.create name: 'Hardcore IPA', style_id: s5.id

u1 = User.create username:'Corvus', password:'Salainen1', password_confirmation:'Salainen1', admin:true
u2 = User.create username:'Cage', password:'Nicolas1', password_confirmation:'Nicolas1', admin:false

b4.beers.first.ratings.create score:50, user_id:u1.id
b1.beers.first.ratings.create score:20, user_id:u1.id

b3.beers.first.ratings.create score:30, user_id:u2.id
b2.beers.first.ratings.create score:43, user_id:u2.id

bc1 = BeerClub.create name: 'Makkaratehtaan kittaajat', founded:1992, city:'Vantaa'
bc2 = BeerClub.create name: 'Tapiolan Tapsanjuojat', founded:1973, city:'Espoo'

bc1.memberships.create user_id:u1.id
bc1.memberships.create user_id:u2.id
bc2.memberships.create user_id:u1.id

b5 = Brewery.create name: 'Testi', year:2007
u3 = User.create username:'Testaaja', password:'Nicolas1', password_confirmation:'Nicolas1', admin:false
[10,20,30].each do |score|
  beer = b5.beers.create name: "Testi #{score}", style_id: s1.id
  beer.ratings.create score:score, user: u3
end
[40,50].each do |score|
  beer = b5.beers.create name: "Testi #{score}", style_id: s2.id
  beer.ratings.create score:score, user: u3
end
