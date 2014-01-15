require "spec_helper"

describe Api::UsersController do
  render_views
  login_user

  context "#search" do
    let!(:other_user) { create :user, full_name: "Oto Brglez" }

    it do
      get :search, query: "brglez"
      expect(assigns(:users).first).to eq other_user
    end
  end

end
