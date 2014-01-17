class Attachment < ActiveRecord::Base
  belongs_to :attachable, polymorphic: true
  mount_uploader :file, AttachmentUploader

  delegate :thumb, :url, :current_path, :identifier, to: :file

  def resource_url

  end

  # /api/steps/:step_id/attachments/:id
end
