require 'spec_helper'

describe Flow do
  it_behaves_like "nameable"
  it_behaves_like "attachable"

  it { should belong_to :creator }
  it { should have_many :flow_accesses }
  it { should have_many :users }
  it { should have_many :steps }
  it { should validate_presence_of(:name).with_message(/can't be blank/) }
  it { should validate_presence_of(:token) }
  #it { should validate_uniqueness_of(:token) }
  it { should be_private }

  let!(:flow) { create :flow }
  let(:creator){ flow.creator }
  let(:other_user){ create :user }

  let(:mailer) { double("FlowMailer", deliver: true) }
  before(:each){ flow.mailer = mailer }


  context "#create" do
    it { expect(mailer).not_to receive(:access_created) }
    it { expect(flow.users).to include(creator) }

    context "#token" do
      subject { flow.token }
      its(:size){ should eq 10 }
    end
  end

  context "#create_flow_access!" do
    it do
      expect(mailer).to receive(:access_created).once.and_return(
        double('Mailer', deliver: true)
      )

      expect { flow.create_flow_access!(other_user) }
      .to change(flow.flow_accesses, :count)
      .from(1).to(2)
    end
  end

  context "#destroy_flow_access!" do
    it do
      expect(mailer).to receive(:access_created).once.
        and_return(mailer)
      expect(mailer).to receive(:access_destroyed).once
        .and_return(mailer)

      flow.create_flow_access!(other_user)

      flow_access = flow.flow_accesses.where(role: "collaborator").last

      expect {
        flow.destroy_flow_access!(flow_access.id)
      }.to change(flow.flow_accesses, :count)
      .from(2).to(1)
    end
  end

  context "#private?" do
    before { subject.public = 1 }
    it { should be_public }
  end
end
