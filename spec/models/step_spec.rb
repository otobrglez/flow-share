require 'spec_helper'

describe Step do

  it_behaves_like "nameable"
  it_behaves_like "attachable"

  it { should belong_to :flow }
  it { should have_many :attachments }

  let!(:user){ create :user }
  let!(:other_user) { create :user }
  let!(:flow){ create :flow_with_steps, creator: user }

  context "complete" do
    before { flow.create_flow_access!(other_user) }
    subject { flow.steps.first }

    let!(:datetime){ DateTime.parse("2014-10-10 10:10:10") }
    before { Timecop.freeze(datetime) }
    after { Timecop.return }

    it {
      expect { subject.update(achiever: other_user) }.to change(subject, :completed?).from(false).to(true)
    }

    it {
      expect { subject.update(achiever: other_user) }
      .to change(subject, :achiever).from(nil).to(other_user)
    }

  end
end
