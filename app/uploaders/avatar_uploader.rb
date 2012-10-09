# encoding: utf-8
require 'carrierwave/mongoid'
class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # default avatar url
  def default_url
    ############TODO
  end

  version :normal do
   process :resize_to_fill  => [100, 100]
  end

  def extension_white_list
   %w(jpg jpeg gif png)
  end
 
  def filename
   "#{model.id}.jpg"
  end

end
