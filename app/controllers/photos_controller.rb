class PhotosController < ApplicationController
    before_action :set_photo, only: [:show, :delete, :destroy]

    def show
        send_file @photo.show_png, type: 'image/jpeg', disposition: 'inline'
    end

    def delete

    end

    def destroy
      p @photo.imageable

      @photo.destroy
      respond_to do |format|
        format.html { redirect_to @photo.imageable, notice: '图片删除成功' }
        format.json { head :no_content }
      end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end


end
