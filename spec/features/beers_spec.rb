require 'spec_helper'
include OwnTestHelper

describe "Beer" do
  let!(:brewery) { FactoryGirl.create :brewery, name:'Koff' }
  let!(:user) { FactoryGirl.create :user }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  describe "With valid name" do
    it "can be registered" do
      visit new_beer_path

      save_and_open_page

      fill_in('beer_name', with:'Koff 3')
      select('Koff', from:"Brewery")
      select('Lager', from:"Style")

      expect {
        click_button('Create Beer')
      }.to change{Beer.count}.by(1)
      expect(current_path).to eq(beers_path)
      expect(page).to have_content('Koff 3')
    end
  end

  describe "Without valid name" do
    it "cannot be registered" do
      visit new_beer_path

      fill_in('beer_name', with:'')
      select('Koff', from:"Brewery")
      select('Lager', from:"Style")

      expect {
        click_button('Create Beer')
      }.not_to change{Beer.count}

      expect(page).to have_content('New beer')
      expect(page).to have_content('Name is too short')

    end
  end


end