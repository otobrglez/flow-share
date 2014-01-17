class Api::AttachmentsController < Api::BaseController

  MODELS = {step_id: Step, flow_id: Flow}

  #TODO: Check if user can access flow?!

  # def create
  #   @attachment = step.attachments.create(attachment_params)
  #   respond_with @attachment, location: [:api, step.flow], status: :created
  # end

  def create
    @attachment = resources.create attachment_params
    respond_with @attachment, status: :created # location: [:api, model],
  end

  def show
    respond_with @attachment = resource
  end

  def destroy
    resource.destroy
    respond_with @attachment = resource
  end

  private

  def model
    unless @model
      param = nil
      MODELS.each do |key, value|
        param ||= key if params.keys.include?(key.to_s)
      end

      @model = MODELS[param].find(params[param])
    end

    @model
  end

  def resources
    model.attachments
  end

  def resource
    @resource ||= resources.find(params[:id])
  end


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
