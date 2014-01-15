class Api::FlowAccessesController < Api::BaseController

  def create
    @flow_access = flow.create_flow_access!(flow_access_params.slice(:user_id))

    respond_with @flow_access, location: [:api, flow, @flow_access], status: :created
  end

  def show
    respond_with flow_access
  end

  def destroy
    @flow_access, status = flow.destroy_flow_access!(params[:id])
    respond_with @flow_access
  end

  private

  def flow_access_params
    params.require(:flow_access).permit(:id, :user_id)
  end

  def flow
    @flow ||= current_user.flows.find(params[:flow_id])
  end

  def flow_access
    @flow_access ||= flow.flow_accesses.find(params[:id])
  end

end

