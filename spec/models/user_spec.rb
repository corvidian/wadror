require 'spec_helper'
include OwnTestHelper

describe User do
  let(:ipa){FactoryGirl.create(:style, name:'IPA') }
  let(:lager){FactoryGirl.create(:style, name:'Lager') }

  it 'has the username set correctly' do
    user = User.new username: 'Pekka'

    user.username.should == 'Pekka'
  end

  it 'is not saved without a password' do
    user = User.create username: 'Pekka'

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  describe 'favorite beer' do
    let(:user){FactoryGirl.create(:user) }

    it 'has method for determining one' do
      user.should respond_to :favorite_beer
    end

    it 'without ratings does not have one' do
      expect(user.favorite_beer).to eq(nil)
    end

    it 'is the only rated if only one rating' do
      beer = FactoryGirl.create(:beer)
      FactoryGirl.create(:rating, beer:beer, user:user)

      expect(user.favorite_beer).to eq(beer)
    end

    it 'is the one with highest rating if several rated' do
      create_beers_with_ratings(10, 20, 15, 7, 9, user, style:ipa)
      best = create_beer_with_rating(25, user, style:ipa)

      expect(user.favorite_beer).to eq(best)
    end
  end

  describe 'with a proper password' do
    let(:user){ FactoryGirl.create(:user) }

    it 'is saved' do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it 'and with two ratings, has the correct average rating' do
      user.ratings << FactoryGirl.create(:rating)
      user.ratings << FactoryGirl.create(:rating2)

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end

  describe 'with too short password' do
    subject{ User.create username: 'Pekka', password: 'F1', password_confirmation: 'F1'
    }
    it { should_not be_valid }
  end

  describe 'with a letter-only password' do
    subject{ User.create username: 'Pekka', password: 'alpakkamajakka', password_confirmation: 'alpakkamajakka'
    }
    it { should_not be_valid }
  end

  describe 'favorite style' do
    let(:user) { FactoryGirl.create :user }


    it 'has method for determining favorite style' do
      user.should respond_to :favorite_style
    end

    it 'is the only rated if only one rating' do
      create_beer_with_rating(10,user,style:ipa)
      expect(user.favorite_style).to eq(name:'IPA',score:10)
    end

    it 'is the highest ranked if several ratings' do
      create_beers_with_ratings(10,20,30,user,style:ipa)
      create_beers_with_ratings(40,50,user, style:lager)

      expect(user.favorite_style).to eq(name:'Lager',score:45)
    end

    it 'is nil without ratings' do
      expect(user.favorite_style).to be(nil)
    end
  end

  describe 'favorite brewery' do
    let(:user) { FactoryGirl.create :user }
    it 'has method for determining favorite brewery' do
      user.should respond_to :favorite_brewery
    end

    it 'is nil without ratings' do
      expect(user.favorite_brewery).to be(nil)
    end

    it 'is the only rated if only one rating' do
      brewery = FactoryGirl.create :brewery
      create_beer_with_rating(10,user,brewery:brewery,style:ipa)
      expect(user.favorite_brewery).to eq(brewery:brewery,score:10)
    end

    it 'is the highest ranked if several ratings' do
      brewery1 = FactoryGirl.create :brewery, name: 'A'
      best = FactoryGirl.create :brewery, name: 'B'
      brewery3 = FactoryGirl.create :brewery, name: 'C'

      create_beers_with_ratings(10,20,30,user,brewery:brewery1,style:ipa)
      create_beers_with_ratings(40,50,user,brewery:best,style:ipa)
      create_beers_with_ratings(10,20,user,brewery:brewery3,style:ipa)

      expect(user.favorite_brewery).to eq(brewery:best,score:45)
    end

  end
end