module Attachable

  extend ActiveSupport::Concern

  included do
    has_many :attachments, -> { where(single: 0) }, as: :attachable

    has_one :image, -> { where(single: 1) }, as: :attachable, class_name: "Attachment", foreign_key: :attachable_id
    delegate :file, to: :image, prefix: true, allow_nil: true
  end

end
