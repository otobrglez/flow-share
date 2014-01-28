class Api::FlowsController < Api::BaseController

  skip_before_action :authenticate_user! # , except: [:show]

  def create
    @flow = current_user.owned_flows.create(flow_params)
    respond_with @flow, location: [:api, @flow], status: :created
  end

  def show
    respond_with flow
  end

  def index
    respond_with flows
  end

  def update
    flow.update flow_params
    respond_with flow
  end

  def destroy
    flow.destroy
    respond_with flow
  end

  private

  def flows
    @flows ||= current_user.flows
  end

  def flow
    if @flow.nil?
      @flow = if params[:id].present?
        flows.find(params[:id])
      elsif params[:token].present?
        Flow.public.find_by(token: params[:token])
      end
    end

    @flow
  end

  def flow_params
    params.require(:flow).permit(:id, :token, :name, :public, :open, steps_attributes: [:id, :flow_id, :name, :comment, :_destroy])
  end



end
