require 'spec_helper'

describe Beer do
  describe "with name and style" do
    subject{ Beer.create name:"Hardcore IPA", style:"IPA"}
    it { should be_valid }
    its(:name) { should eq("Hardcore IPA") }
    its(:style) { should eq("IPA") }
  end

  describe "without name" do
    subject{ Beer.create style:"IPA"}

    it { should_not be_valid }
  end

  describe "without style" do
    subject{ Beer.create name:"Hardcore IPA"}

    it { should_not be_valid }
  end

end

describe 'Beers' do
  let!(:user){ FactoryGirl.create :user }
  before :each do
  end

  it "with one style reports that style" do
    create_beer_with_rating(10, user, style:'IPA')

    expect(Beer.styles).to eq(['IPA'])
  end

  it "with many styles reports those" do
    styles = ["Weizen", "Lager", "Pale ale", "IPA", "Porter"]
    styles.each do |style|
      create_beer_with_rating(10, user, style:style)
    end

  end

end
