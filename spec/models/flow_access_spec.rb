require "spec_helper"

describe FlowAccess do

  it { should belong_to :flow }
  it { should belong_to :user }

  context "user management" do
    let(:flow) { create :flow }
    let(:creator) { flow.creator }

    context "#cant_remote_creator" do
      subject { flow.flow_accesses.first }
      it { expect(subject.destroy).to be_false }
      it { expect { subject.destroy }.to change(subject.errors, :count).by(1) }
    end

    context "#user_per_flow" do
      let(:other_user){ create :other_user }
      before { flow.create_flow_access!(other_user)  }

      it { expect(flow.users).to include(other_user) }

      it do
        expect { flow.create_flow_access!(other_user) }
        .to raise_error(ActiveRecord::RecordInvalid, /already has access/ )
      end
    end

  end

end
