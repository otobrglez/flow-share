class Step < ActiveRecord::Base
  include Nameable
  include RankedModel

  belongs_to :flow
  belongs_to :creator, class_name: "User"

  ranks :row_order, with_same: :flow_id

  validates :name, presence: true

  def complete! user
    update(completed: 1)
  end

end
