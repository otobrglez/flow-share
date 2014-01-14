class Api::StepsController < Api::BaseController

  def complete
    step.update(completed: 1)
    respond_with step
  end

  def create
    @flow = Flow.find(params[:flow_id]) # UNSECURE
    @step = @flow.steps.create(step_params)

    respond_with @step, location: [:api, @flow, @step], status: :created
  end

  def update
    step.update step_params
    respond_with step
  end

  def destroy
    step.destroy
    respond_with step
  end

  private

  def step_params
    params.require(:step).permit(:id, :name, :comment, :row_order_position)
  end

  def step
    @step ||= Step.find_by(flow_id: params[:flow_id], id: params[:id])
  end

end
