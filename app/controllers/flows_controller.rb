class FlowsController < ApplicationController

  respond_to :html, :js

  def index
    respond_with @flows=Flow.all
  end

  def new
    @flow = Flow.new
    @flow.steps.build(name: "Step 1")

    @flows = Flow.all

    respond_with @flow
  end

  def create
    @flow = Flow.new(flow_params)
    if @flow.save
      @flow = nil
    end

    @flows = Flow.all

    render "index"
  end

  def destroy
    @flow = Flow.find(params[:id])
    @flow.destroy

    @flows = Flow.all
  end

  def edit
    @flow = Flow.find(params[:id])

    @flows = Flow.all

    render "index"
  end

  def update
    @flow = Flow.find(params[:id])

    if @flow.update(flow_params)
      @flow = nil
    end

    @flows = Flow.all

    render "index"
  end



  private

  def flow_params
    params.require(:flow).permit(:id, :name, steps_attributes: [:id, :flow_id, :name, :comment, :_destroy])
  end



end
