module ApplicationHelper

  def public_flow_url flow=nil
    flow ||= @flow
    flow_url token: flow.to_public_param
  end

  def public_flow_path flow=nil
    flow ||= @flow
    flow_path token: flow.to_public_param
  end

end
