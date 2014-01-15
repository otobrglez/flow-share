require "spec_helper"

describe Api::FlowsController do
  render_views
  login_user

  let!(:flow){ create(:flow, creator: user)}

  context "#create" do
    let(:new_flow){ attributes_for(:flow, name:"Test me") }

    it do
      expect { post(:create, flow: new_flow) }
      .to change { user.flows.count }.by(1)
    end

    it "creates flow" do
      post :create, flow: new_flow

      expect(response).to be_success
      expect(assigns(:flow).name).to eq new_flow[:name]
    end
  end

  context "#show" do
    it "has flow" do
      get :show, id: flow.id

      expect(response).to be_success
      expect(assigns(:flow)).to eq flow
    end
  end

  context "#index" do
    it "has flows" do
      get :index

      expect(response).to be_success
      expect(assigns(:flows)).to include flow
    end
  end

  context "#update" do
    it do
      patch :update, id: flow.id, flow: { name: "updated title" }

      expect(assigns(:flow).name).to eq "updated title"
    end
  end

  context "#destroy" do
    it do
      expect { delete :destroy, id: flow.id }
      .to change { user.flows.count }.by(-1)
    end

    it do
      delete :destroy, id: flow.id
      expect(response).to be_success
    end
  end


end
