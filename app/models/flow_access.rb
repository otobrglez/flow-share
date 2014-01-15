class FlowAccess < ActiveRecord::Base
  belongs_to :flow
  belongs_to :user

  validate :user_per_flow
  before_destroy :cant_remote_creator

  def cant_remote_creator
    status = true

    if flow.creator_id == user_id or flow.creator == user
      errors.add(:base, "You can't remove creator from flow")
      status = false
    end

    status
  end

  def user_per_flow
    if flow.flow_accesses.exists?(user_id: user_id)
      errors.add(:base, "User already has access to flow")
    end
  end


end
