class Step < ActiveRecord::Base
  include Nameable

  belongs_to :flow

  belongs_to :creator, class_name: "User"


end
