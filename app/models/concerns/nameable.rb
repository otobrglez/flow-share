module Nameable

  extend ActiveSupport::Concern

  def to_s
    name
  end


end
