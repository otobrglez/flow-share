require "spec_helper"

describe Api::StepsController do
  render_views
  login_user

  let(:default_params){ { flow_id: flow.id, format: :json } }

  let!(:flow){ create :flow_with_steps, creator: user }

  context "#create" do
    let(:new_step) { attributes_for(:step) }

    it do
      post :create, step: new_step

      expect(assigns(:step).name).to eq new_step[:name]
    end
  end

  context "#complete" do
    let(:step){ flow.steps.first }

    it do
      get :complete, id: step.id

      expect(response).to be_success
      expect(assigns[:step]).to be_completed
    end
  end

  context "#update" do
    let(:step){ flow.steps.first }

    it do
      put :update, id: step.id, step: { name: "New name" }
      expect(response).to be_success
      expect(assigns[:step].name).to eq "New name"
    end
  end

  context "#destroy" do
    let(:step){ flow.steps.first }

    it do
      expect { delete :destroy, id: step.id }
      .to change { flow.steps.count }.by(-1)
    end

    it do
      delete :destroy, id: step.id
      expect(response).to be_success
    end

  end

end
