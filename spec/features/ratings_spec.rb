require 'spec_helper'
include OwnTestHelper

describe "Rating" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryGirl.create :user }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end

  describe "with many ratings" do
    before :each do
      scores = [10, 20, 30, 40, 50]
      scores.each do |score|
        FactoryGirl.create :rating, beer_id:1, score: score, user_id:1
        FactoryGirl.create :rating, beer_id:2, score: score, user_id:1
      end
    end
    it "lists ratings and shows their count" do
      visit ratings_path

      expect(page).to have_content('iso 3')
      expect(page).to have_content('Karhu')
      expect(page).to have_content('Number of ratings: 10')

      save_and_open_page
    end
  end

end