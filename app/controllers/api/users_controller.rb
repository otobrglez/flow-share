class Api::UsersController < Api::BaseController

  def search
    respond_with @users = User.search_name(search_params["query"])
  end

  def show
    respond_with user = User.find(params[:id])
  end

  private

  def search_params
    params.permit!
  end

end
