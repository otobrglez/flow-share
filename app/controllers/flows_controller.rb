class FlowsController < ApplicationController

  respond_to :html
  layout "app"

  def show
    respond_with flow
  end

  private

  def flow
    @flow ||= Flow.public.find_by(token: token)
  end

  def token
    @token ||= params[:token].split("-",0).first
  end

end
