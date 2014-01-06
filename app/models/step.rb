class Step < ActiveRecord::Base
  include Nameable

  belongs_to :flow

end
