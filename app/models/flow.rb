class Flow < ActiveRecord::Base
  include Nameable

  belongs_to :creator, class_name: "User"

  has_many :flow_accesses, ->{ order({role: :desc, updated_at: :desc}) }, foreign_key: :flow_id, dependent: :destroy
  has_many :users, through: :flow_accesses

  has_many :steps, dependent: :destroy

  validates :name, presence: true

  after_create ->{ create_flow_access! creator }

  def create_flow_access! other_user, options={role: "collaborator"}
    flow_accesses.create!({user: other_user}.reverse_merge!(options))
  end

end
