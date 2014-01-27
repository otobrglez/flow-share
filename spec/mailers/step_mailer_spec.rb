require "spec_helper"

describe StepMailer do

  let(:flow){ create :flow_with_steps }
  let(:step){ flow.steps.first }
  let(:other_user){ create :user }

  before { flow.create_flow_access!(other_user) }

  describe "notify_about_achieved" do
    let(:mail){ StepMailer.achieved(step, flow.users.first, other_user) }
    it { expect(mail.subject).to match /completed/ }
    it { expect(mail.body.encoded).to match /completed/ }
  end

end
