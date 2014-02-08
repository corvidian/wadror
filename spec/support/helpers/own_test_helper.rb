module OwnTestHelper

  def sign_in(credentials)
    visit signin_path
    fill_in('username', with:credentials[:username])
    fill_in('password', with:credentials[:password])
    click_button('Log in')
  end



  def create_beer_with_rating(score, user, style:'Lager', brewery: nil)
    beer = FactoryGirl.create(:beer, style:style, brewery:brewery)
    FactoryGirl.create(:rating, score:score, beer:beer, user:user)
    beer
  end

  def create_beers_with_ratings(*scores, user, style:'Lager', brewery: nil)
    scores.each do |score|
      create_beer_with_rating(score, user, style:style, brewery:brewery)
    end
  end

end