class BaseController < ApplicationController

  before_filter :authenticate_user!
  layout "app"

  def app
    render "app"
  end

end
