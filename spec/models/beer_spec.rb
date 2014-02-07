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
