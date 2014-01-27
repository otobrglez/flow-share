require 'spec_helper'

describe Step do

  it_behaves_like "nameable"
  it_behaves_like "attachable"

  it { should belong_to :flow }
  it { should have_many :attachments }

  let!(:user){ create :user }
  let!(:other_user) { create :user }
  let!(:flow){ create :flow_with_steps, creator: user }

  before { flow.create_flow_access!(other_user) }

  context "complete" do
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

  context "complete mail" do
    let(:mailer) { double("StepMailer", deliver: true) }
    let!(:step){ flow.steps.first }

    before { step.mailer = mailer  }

    it "#notify_about_achieved" do
      expect(mailer).to receive(:notify_about_achieved).with(step).once
      step.update(achiever: other_user)
    end

  end
end
