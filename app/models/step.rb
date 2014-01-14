class Step < ActiveRecord::Base
  include Nameable
  include RankedModel

  belongs_to :flow

  belongs_to :creator, class_name: "User"

  ranks :row_order, with_same: :flow_id

  # default_scope -> { rank(:row_order) }

  validates :name, presence: true

end
