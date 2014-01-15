class Api::UsersController < Api::BaseController

  def search
    respond_with @users = User.search_name(search_params["query"])
  end

  private

  def search_params
    params.permit!
  end

end
