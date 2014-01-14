class Api::FlowAccessesController < Api::BaseController

  def create
    @flow = Flow.find(params[:flow_id]) # UNSECURE
    @flow_access = @flow.flow_accesses.create(
      flow_access_params.reverse_merge!(role: "collaborator")
    )

    respond_with @flow_access, location: [:api, @flow, @flow_accesses], status: :created
  end

  def destroy
    flow_access.destroy
    respond_with flow_access
  end

  def show
    respond_with flow_access
  end

  private

  def flow_access_params
    params.require(:flow_access).permit(:id, :user_id)
  end

  def flow_access
    @flow_access ||= FlowAccess.find_by(flow_id: params[:flow_id], id: params[:id])
  end

end

