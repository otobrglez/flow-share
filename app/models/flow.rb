class Flow < ActiveRecord::Base
  include Nameable

  belongs_to :creator, class_name: "User"

  has_many :flow_accesses, ->{ order({role: :desc, updated_at: :desc}) }, foreign_key: :flow_id, dependent: :destroy
  has_many :users, through: :flow_accesses

  has_many :steps, dependent: :destroy

  has_one :attachment, as: :attachable
  delegate :file, to: :attachment, prefix: true, allow_nil: true

  validates :name, presence: true

  after_create ->{ create_flow_access!(creator, role: "creator") }

  def create_flow_access! other_user, options={role: "collaborator"}
    other_user = User.find(other_user[:user_id]) unless other_user.is_a?(User)
    flow_accesses.create!({user: other_user}.reverse_merge!(options))
  end

  def destroy_flow_access! flow_access_id
    flow_access = flow_accesses.find(flow_access_id)
    status = flow_access.destroy
    [flow_access, status]
  end



end
