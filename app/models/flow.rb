class Flow < ActiveRecord::Base
  include Nameable

  belongs_to :creator, class_name: "User"

  has_many :flow_accesses, foreign_key: :flow_id
  has_many :users, through: :flow_accesses


  has_many :steps, -> { order(id: :asc) }, dependent: :destroy

  default_scope -> { order(id: :desc) }

  validates :name, presence: true

  accepts_nested_attributes_for :steps, allow_destroy: true,
    reject_if: proc { |attributes| attributes['name'].blank? }

  after_create ->{
    FlowAccess.create(flow_id: self.id, user_id: self.creator_id)
  }

end
