class Api::AttachmentsController < Api::BaseController

  #TODO: Check if user can access flow?!

  def create
    @attachment = step.attachments.create(attachment_params)
    respond_with @attachment, location: [:api, step.flow], status: :created
  end

  def show
    respond_with attachment
  end

  private

  def attachment_params
    params.require(:attachment).permit!
  end

  def attachment
    @attachment ||= step.attachments.find(params[:id])
  end

  def step
    @step ||= Step.find(params[:step_id])
  end

end
