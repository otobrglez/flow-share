require "spec_helper"

describe Api::FlowAccessesController do
  render_views
  login_user

  let(:default_params){ { flow_id: flow.id, format: :json } }

  let!(:flow){ create(:flow, creator: user) }
  let!(:other_user){ create :user }

  context "#create" do
    it do
      post :create, flow_access: { user_id: other_user.id }

      expect(other_user.flows).to include flow
      expect(assigns(:flow_access).user).to eq other_user
      expect(response).to be_success
    end
  end

  context "#show" do
    it do
      get :show, id: flow.flow_accesses.first.id

      expect(assigns(:flow_access)).to eq flow.flow_accesses.first
      expect(response).to be_success
    end
  end

  context "#destroy" do
    it do
      delete :destroy, id: flow.flow_accesses.first.id

      expect(flow.flow_accesses).not_to be_empty
    end

    it do
      flow.create_flow_access! other_user

      expect {
        delete :destroy, id: flow.flow_accesses.last.id
      }.to change(flow.flow_accesses, :count).by(-1)
    end
  end

end
