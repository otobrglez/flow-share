class FlowsController < BaseController

  respond_to :html, :js

  def index
    respond_with @flows=current_user.flows
  end

  def new
    @flows = current_user.flows

    @flow = Flow.new(creator: current_user)
    @flow.steps.build(name: "Step 1")


    respond_with @flows
  end

  def create
    @flow = current_user.owned_flows.build(
      flow_params.reverse_merge!(creator_id: current_user.id)
    )

    if @flow.save
      @flow = nil
    end

    @flows = current_user.flows

    render "index"
  end

  def destroy
    @flow = current_user.flows.find(params[:id])
    @flow.destroy

    @flows = current_user.flows
  end

  def edit
    @flow = current_user.flows.find(params[:id])

    @flows = current_user.flows

    render "index"
  end

  def update
    @flow = current_user.flows.find(params[:id])

    if @flow.update(flow_params)
      @flow = nil
    end

    @flows = current_user.flows

    render "index"
  end



  private

  def flow_params
    params.require(:flow).permit(:id, :name, steps_attributes: [:id, :flow_id, :name, :comment, :_destroy])
  end



end
