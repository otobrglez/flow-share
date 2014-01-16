require "spec_helper"

describe Api::AttachmentsController do
  render_views
  login_user

  let!(:flow){ create(:flow, creator: user)}

  #TODO: Add spec for attachments

end
