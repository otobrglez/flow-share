class StepsController < ApplicationController

  respond_to :js

  def complete
    @step = Step.find_by(flow_id: params[:flow_id], id: params[:step_id])
    @step.update(completed: 1)

    @flows = Flow.all

    render "flows/index"
  end

end
