require 'spec_helper'

describe User do
  it "has the username set correctly" do
    user = User.new username:"Pekka"

    user.username.should == "Pekka"
  end

  it "is not saved without a password" do
    user = User.create username:"Pekka"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  

  describe "with a proper password" do
    let(:user){ FactoryGirl.create(:user) }

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      user.ratings << FactoryGirl.create(:rating)
      user.ratings << FactoryGirl.create(:rating2)

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end

  describe "with too short password" do
    subject{ User.create username:"Pekka", password:"F1", password_confirmation:"F1"}
    it { should_not be_valid }
  end

  describe "with a letter-only password" do
    subject{ User.create username:"Pekka", password:"alpakkamajakka", password_confirmation:"alpakkamajakka"}
    it { should_not be_valid }
  end
end