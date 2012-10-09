# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # default avatar url
  def default_url
    ############TODO
  end

   version :normal do
     process :scale => [100, 100]
   end

   def extension_white_list
     %w(jpg jpeg gif png)
   end

   def filename
    ####TODO
   end

end
