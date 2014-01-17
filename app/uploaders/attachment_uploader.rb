require 'carrierwave/processing/mime_types'

class AttachmentUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include CarrierWave::MimeTypes

  def store_dir
    # "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    "uploads/#{model.attachable_type.to_s.underscore}/#{model.id}"
  end

  def default_url
    ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  end

  process :set_content_type
  process :save_content_type_and_size_in_model

  version :thumb, :if => :image? do
    process :resize_to_fit => [300, 300]
  end

  def extension_white_list
    %w(jpg jpeg gif png)+ %w(pdf doc docx xls xlsx ppt pptx)
  end

  def save_content_type_and_size_in_model
    model.content_type = file.content_type if file.content_type
    model.file_size = file.size.to_i
    model.name = file.original_filename if file.original_filename
  end

  protected

  def image?(new_file)
    new_file.content_type.include? 'image'
  end


  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :scale => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
