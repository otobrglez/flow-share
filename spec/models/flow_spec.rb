require 'spec_helper'

describe Flow do

  it_behaves_like "nameable"
  it_behaves_like "attachable"

  it { should belong_to :creator }
  it { should have_many :flow_accesses }
  it { should have_many :users }
  it { should have_many :steps }
  it { should validate_presence_of(:name).with_message(/can't be blank/) }

  context "adds FlowAccess" do
    subject { create :flow }
    it { expect(subject.users).to include(subject.creator) }
  end
end
