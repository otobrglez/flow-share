class Api::StepsController < Api::BaseController

  def create
    @step = flow.steps.create(step_params)
    respond_with @step, location: [:api, flow, @step], status: :created
  end

  def show
    respond_with step
  end

  def update
    respond_with step.update(step_params)
  end

  def destroy
    step.destroy
    respond_with step
  end

  private

  def step_params
    params.require(:step).permit(:id, :name, :comment, :achiever_id, :assignee_id,  :row_order_position)
  end

  def flow
    @flow ||= current_user.flows.find(params[:flow_id])
  end

  def step
    @step ||= flow.steps.find(params[:id])
  end

end
