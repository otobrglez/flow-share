class Api::FlowsController < Api::BaseController

  def index
    respond_with flows
  end

  def show
    respond_with @flow = flows.find(params[:id])
  end

  def create
    @flow = current_user.owned_flows.create(
      flow_params.reverse_merge!(creator_id: current_user.id)
    )

    respond_with @flow, location: [:api, @flow], status: :created
  end

  def destroy
    @flow = current_user.flows.find(params[:id])
    @flow.destroy

    respond_with @flow
  end

  def update
    @flow = current_user.flows.find(params[:id])
    @flow.update(flow_params)

    respond_with @flow
  end

  private

  def flows
    @flows ||= current_user.flows
  end

  def flow_params
    params.require(:flow).permit(:id, :name, steps_attributes: [:id, :flow_id, :name, :comment, :_destroy])
  end



end
