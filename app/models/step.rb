class Step < ActiveRecord::Base
  include Nameable
  include RankedModel
  include Attachable

  belongs_to :flow

  ranks :row_order, with_same: :flow_id

  validates :name, presence: true

  def complete! user
    update(completed: 1)
  end

end
