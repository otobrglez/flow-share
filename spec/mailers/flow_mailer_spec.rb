require "spec_helper"

describe FlowMailer do

  let(:flow){ create :flow }
  let(:other_user){ create :user }
  before { flow.create_flow_access!(other_user) }
  let(:flow_access) { flow.flow_accesses.last }

  %w{access_created access_destroyed}.each do |method|
    context method do
      let(:mail){ FlowMailer.send(method, flow_access) }
      it { expect(mail.subject).to match /-\ FlowShare/}
      it { expect(mail.to).to include flow_access.user.email }
      it { expect(mail.from).to include ENV["MAIL_SENDER"] }
      it { expect(mail.body.encoded).to match /perfect flow/i }
    end
  end

end
