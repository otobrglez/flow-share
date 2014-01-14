class Api::UsersController < Api::BaseController

  def search
    @users = User.search_name(search_params["query"])
    respond_with @users
  end

  private

  def search_params
    params.permit!
  end

end
