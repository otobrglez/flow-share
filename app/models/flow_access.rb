class FlowAccess < ActiveRecord::Base
  belongs_to :flow
  belongs_to :user

  before_destroy :cant_remote_creator
  validate :one_user_per_flow

  def one_user_per_flow
    if flow.flow_accesses.exists?(user_id: user_id)
      errors.add(:base, "User already has access to flow")
    end
  end


  private


  def cant_remote_creator
    if flow.creator == user
      errors.add(:base, "Can't remove creator")
      return false
    end
  end



end
