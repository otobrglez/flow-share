class Api::BaseController < ApplicationController

  respond_to :json

  before_filter :authenticate_user!

  # protect_from_forgery with: :null_session

end
