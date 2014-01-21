class Attachment < ActiveRecord::Base
  include Colorist

  belongs_to :attachable, polymorphic: true
  mount_uploader :file, AttachmentUploader

  delegate :thumb, :url, :current_path, :identifier, to: :file

  def resource_url
    #TODO: Build one.
  end

  def color_invert
    if color.present?
      Colorist::Color.from(color).text_color.to_s rescue "#000000"
    end
  end

end
