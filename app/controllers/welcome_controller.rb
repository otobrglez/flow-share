class WelcomeController < ApplicationController

  before_filter :redirect_signed


  def index
  end

  def validate_email
    render text: "Please check your email! Thanks"
  end

  private

  def redirect_signed
    if user_signed_in?
      redirect_to flows_path
    end
  end

end
