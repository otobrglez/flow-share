require 'spec_helper'

describe User do

  it { should have_many(:owned_flows) }
  it { should have_many(:flows) }
  it { should have_many(:flow_accesses) }

  it { should validate_uniqueness_of :username }
  it { should validate_presence_of :username }
  it { should ensure_length_of(:username).is_at_least(3).is_at_most(25) }
  it { should allow_value('otobrglez').for(:username) }
  it { should_not allow_value('99').for(:username) }

  it do
    should allow_value('kekec','rf45')
    .for(:username)
    .with_message(/alphanumeric/)
  end

  context "#to_s" do
    subject { build :user }
    it { expect(User.new.to_s).to be_nil }
    its(:to_s){ should eq subject.username }
  end
end
