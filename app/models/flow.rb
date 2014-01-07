class Flow < ActiveRecord::Base
  include Nameable

  has_many :steps, -> { order(id: :asc) }, dependent: :destroy

  default_scope -> { order(id: :desc) }

  validates :name, presence: true

  accepts_nested_attributes_for :steps, allow_destroy: true,
    reject_if: proc { |attributes| attributes['name'].blank? }

end
