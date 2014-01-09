class FlowAccess < ActiveRecord::Base
  belongs_to :flow
  belongs_to :user

end
