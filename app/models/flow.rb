class Flow < ActiveRecord::Base
  include Nameable

  has_many :steps, dependent: :destroy

  default_scope -> { order(id: :desc) }

  validates :name, presence: true

  accepts_nested_attributes_for :steps
end
