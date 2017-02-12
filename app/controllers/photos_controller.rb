class PhotosController < ApplicationController
    before_action :set_photo, only: [:show]

    def show
        send_file @photo.show_png, type: 'image/jpeg', disposition: 'inline'
    end
    private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end
end
