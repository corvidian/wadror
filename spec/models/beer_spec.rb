require 'spec_helper'

describe Beer do
  let(:ipa) { FactoryGirl.create :style, name:'IPA'}
  describe 'with name and style' do
    subject{ Beer.create name: 'Hardcore IPA', style:ipa
    }
    it { should be_valid }
    its(:name) { should eq('Hardcore IPA') }
    its(:style) { should eq(ipa) }
  end

  describe 'without name' do
    subject{ Beer.create style:ipa
    }

    it { should_not be_valid }
  end

  describe 'without style' do
    subject{ Beer.create name: 'Hardcore IPA'
    }

    it { should_not be_valid }
  end

end
