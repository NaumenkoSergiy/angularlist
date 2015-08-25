require 'spec_helper'

describe Task do
  context 'validation rules' do
    subject { FactoryGirl.build(:task) }
    it { should be_valid }
    it { should validate_presence_of(:title) }
    it { should validate_numericality_of(:priority) }
  end

  context '#complete!' do
    subject { FactoryGirl.create(:active_task) }

    before do
      subject.complete!
    end

    it { should be_completed }
  end

  context '#restore!' do
    subject { FactoryGirl.create(:completed_task) }

    before do
      subject.restore!
    end

    it { should_not be_completed }
  end
end
