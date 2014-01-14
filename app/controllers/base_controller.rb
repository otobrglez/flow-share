class BaseController < ApplicationController

  before_filter :authenticate_user!

  def app
    render "app", layout: false
  end

end
