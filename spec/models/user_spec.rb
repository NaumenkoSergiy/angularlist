require 'spec_helper'

describe User do
  context 'validation rules' do
    subject { FactoryGirl.build(:user) }

    it { should be_valid }
  end

  context '#full_name' do
    subject { FactoryGirl.build(:user, first_name: 'Eugene', last_name: 'Korpan') }

    its(:full_name) { should eq('Eugene Korpan') }
  end
end
