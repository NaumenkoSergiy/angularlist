require 'spec_helper'

describe Task do
  context 'validation rules' do
    subject { FactoryGirl.build(:task) }
    it { should be_valid }
    it { should validate_presence_of(:title) }
  end
end
