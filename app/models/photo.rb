class Photo < ApplicationRecord
  belongs_to :imageable, polymorphic: true

  def show_png
    case self.imageable_type
    when "RecDoc"
      folder = File.expand_path(".") + "/pic_tmp/"
    when "FixedAsset"
      folder = File.expand_path(".") + "/upload/"
    end
    png_name = folder + self.file_name
    return png_name
    # send_file png_name, type: 'image/png', disposition: 'inline'
  end
end
