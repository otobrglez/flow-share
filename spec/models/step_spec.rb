require 'spec_helper'

describe Step do

  it_behaves_like "nameable"

  it { should belong_to :flow }
  it { should have_many :attachments }


  let!(:user){ create :user }
  let!(:other_user) { create :user }
  let!(:flow){ create :flow_with_steps, creator: user }

  context "#complete!" do
    before { flow.create_flow_access!(other_user) }
    subject { flow.steps.first }
    it do
      expect { subject.complete!(other_user) }
      .to change(subject, :completed?).from(false).to(true)
    end
  end
end
