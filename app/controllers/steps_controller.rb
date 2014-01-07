class StepsController < ApplicationController

  respond_to :js

  def destroy
    @flow = Flow.find(params[:flow_id])
    @step = @flow.find(params[:id])

    @step.destroy


    render js: "alert('ok!');"
  end

end
