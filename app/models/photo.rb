class Photo < ApplicationRecord
  belongs_to :imageable, polymorphic: true

  def show_png
    folder = File.expand_path(".")+"/upload/"
    png_name = folder + self.file_name
    # send_file png_name, type: 'image/png', disposition: 'inline'
  end
end
