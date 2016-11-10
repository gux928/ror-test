require "active_support/all"
require 'RMagick'
include Magick
class RecDocsController < ApplicationController
  before_action :set_rec_doc,:login_check, only: [:show, :edit, :update, :destroy,:print]

  # GET /rec_docs
  # GET /rec_docs.json
  def index
    @q=RecDoc.ransack(params[:q])
    if params[:q].nil?
      @rec_docs = RecDoc.paginate(page: params[:page], per_page: 10).order(riqi: :desc)
    else
      @rec_docs=@q.result.paginate(page: params[:page], per_page: 10).order(created_at: :desc)
    end
    p @rec_docs
  end

  # GET /rec_docs/1
  # GET /rec_docs/1.json
  def show
    # @page_num=0
    @png_exist=set_png
    p "****************"
    p @rec_doc.tiff
    p "****************"
  end

  # GET /rec_docs/new
  def new
    p params[:type]
    @rec_doc = RecDoc.new
    @rec_doc.year=Time.now.year
    @rec_doc.year_num=RecDoc.where("year = ? AND doc_type = ?",Time.now.year,params[:type]).count+1
    @rec_doc.doc_type=params[:type]
    p @rec_doc
    @page_num=0
  end



  # GET /rec_docs/1/edit
  def edit
    p @rec_doc
    @png_exist=set_png
  end

  # GET /rec_docs/1/print
  # def print
  #   render :layout => false
  # end

  # POST /rec_docs
  # POST /rec_docs.json
  def create
    p "****************"
    p rec_doc_params
    p "****************"
    rec_doc_params["riqi(1i)"]=rec_doc_params["riqi_year"]
    rec_doc_params["riqi(2i)"]=rec_doc_params["riqi_month"]
    rec_doc_params["riqi(3i)"]=rec_doc_params["riqi_day"]

    @rec_doc = RecDoc.new(rec_doc_params)
    set_tiff
    p @rec_doc.tiff
    respond_to do |format|
      if @rec_doc.save
        format.html { redirect_to @rec_doc, notice: '保存成功！' }
        format.json { render :show, status: :created, location: @rec_doc }
      else
        format.html { render :new }
        format.json { render json: @rec_doc.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rec_docs/1
  # PATCH/PUT /rec_docs/1.json
  def update
    rec_doc_params["riqi(1i)"]=rec_doc_params["riqi_year"]
    rec_doc_params["riqi(2i)"]=rec_doc_params["riqi_month"]
    rec_doc_params["riqi(3i)"]=rec_doc_params["riqi_day"]
    # p "212121212121212121212121212121212121212121212121212121212"
    # RecDoc.update(rec_doc_params)
    # p "*********tttttttttwerwerewrwerewrwerewrewrewrt*******"
    # set_tiff
    # p @rec_doc.tiff
    respond_to do |format|
      if @rec_doc.update(rec_doc_params)
        set_tiff
        format.html { redirect_to @rec_doc, notice: '修改成功！' }
        format.json { render :show, status: :ok, location: @rec_doc }
      else
        format.html { render :edit }
        format.json { render json: @rec_doc.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rec_docs/1
  # DELETE /rec_docs/1.json
  def destroy
    @rec_doc.destroy
    respond_to do |format|
      format.html { redirect_to rec_docs_url, notice: '文件已删除' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rec_doc
      @rec_doc = RecDoc.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rec_doc_params
      params.require(:rec_doc).permit(:wjnr, :riqi, :year, :year_num, :from, :from_code,:doc_type,:tiff,:png_num)
    end


    # png 文件保存在/approot/public/png/
    def set_png
      return false if @rec_doc.tiff.nil?||!File.exist?(File.expand_path(".")+"/upload/"+@rec_doc.tiff+".tif")
      tiff = ImageList.new(File.expand_path(".")+"/upload/"+@rec_doc.tiff+".tif")
      @rec_doc.png_num=tiff.length
      @rec_doc.save
      # set_rec_doc
      return true if File.exist?(File.expand_path(".")+"/public/png/"+@rec_doc.tiff+"/png-0.png")
      # p "+++++++++++++++++++++"
      # p tiff.length
      # p "+++++++++++++++++++++"
      # @page_num=tiff.length
      # smallcat = cat.minify
      # smallcat.display
      Dir.mkdir(File.expand_path(".")+"/public/png/"+@rec_doc.tiff)
      tiff.write(File.expand_path(".")+"/public/png/"+@rec_doc.tiff+"/png.png")
      return true
    end

    def set_tiff
      @rec_doc.png_num=0
      @rec_doc.save
      p "##@@@@@@@@@@@@@@@@@@@"
      p rec_doc_params[:tiff]
      p "##@@@@@@@@@@@@@@@@@@@"
      return if rec_doc_params[:tiff].nil?
      @rec_doc.tiff=@rec_doc.doc_type.to_s+"-"+@rec_doc.year.to_s+"-"+@rec_doc.year_num.to_s
      # tif文件保存在/approot／upload/
      real_file=File.expand_path(".")+'/upload/'+@rec_doc.tiff+".tif"
      uploaded_io=rec_doc_params[:tiff]
      File.open(real_file,'wb') do |file|
        file.write(uploaded_io.read)
      end
      tiff = ImageList.new(File.expand_path(".")+"/upload/"+@rec_doc.tiff+".tif")
      @rec_doc.png_num=tiff.length
      @rec_doc.save
      Dir.mkdir(File.expand_path(".")+"/public/png/"+@rec_doc.tiff)
      tiff.write(File.expand_path(".")+"/public/png/"+@rec_doc.tiff+"/png.png")
    end

    def login_check
      redirect_to login_path if !logged_in?
    end

end
