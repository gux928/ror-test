# encoding: utf-8
require "active_support/all"
require 'RMagick'
include Magick
class RecDocsController < ApplicationController
  before_action :login_check
  before_action :set_rec_doc, only: [:show, :edit, :update, :destroy, :tiff]

  # GET /rec_docs
  # GET /rec_docs.json
  def index
    # @q = RecDoc.ransack(params[:q])
    page_limit = params[:page_limit]||10
    # my_key暂存搜索关键字
    my_key = ""
    my_key = params[:q][:from_or_from_code_or_wjnr_cont] unless params[:q].nil?||params[:q][:from_or_from_code_or_wjnr_cont].nil?
    p my_key
    my_doc_type = { "收文" => "doc_type = 0" , "信访" => "doc_type = 1" }
    my_doc_type.default =  ""
    func_key = my_key.split(' ').first || ""
    # p params
    if func_key == "收文" || func_key == "信访" #如果前缀收文或者信访关键字 则切分出来
      params[:q][:from_or_from_code_or_wjnr_cont] = my_key.split(' ',2)[1]||""
    end
    # p params
    @q = RecDoc.ransack(params[:q])
    @rec_docs = @q.result.where(my_doc_type[func_key.to_sym]).paginate(page: params[:page], per_page: page_limit).order(year: :desc,year_num: :desc)
    params[:q][:from_or_from_code_or_wjnr_cont] = my_key unless params[:q].nil?||params[:q][:from_or_from_code_or_wjnr_cont].nil?
    @q = RecDoc.ransack(params[:q])
  end

  # GET /rec_docs/1
  # GET /rec_docs/1.json
  def show
    set_png
  end

  # GET /rec_docs/new
  def new
    p params[:type]
    @time=Time.now
    @rec_doc = RecDoc.new
    @rec_doc.year=Time.now.year
    @rec_doc.year_num=RecDoc.where("year = ? AND doc_type = ?",Time.now.year,params[:type]).count+1
    @rec_doc.doc_type=params[:type]
    # p @rec_doc
    # @page_num=0
  end



  # GET /rec_docs/1/edit
  def edit
    p @rec_doc
    if @rec_doc.riqi.nil?
      @time=Time.new(2007,1,1)
    else
      @time=@rec_doc.riqi
    end
    set_png
  end

  # GET /rec_docs/1/print
  # def print
  #   render :layout => false
  # end

  # POST /rec_docs
  # POST /rec_docs.json
  def create
    @time=Time.now
    # p "****************"
    # p rec_doc_params
    # p "****************"
    rec_doc_params["riqi(1i)"]=rec_doc_params["riqi_year"]
    rec_doc_params["riqi(2i)"]=rec_doc_params["riqi_month"]
    rec_doc_params["riqi(3i)"]=rec_doc_params["riqi_day"]

    @rec_doc = RecDoc.new(rec_doc_params)

    respond_to do |format|
      if @rec_doc.save
        unless rec_doc_params[:tiff].nil?
          require "FileUtils"
          file_move_to = File.expand_path(".")+'/upload/'+@rec_doc.tiff
          FileUtils.move rec_doc_params[:tiff].path,file_move_to
          set_tiff rec_doc_params[:tiff].path
        end
        p @rec_doc.tiff
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
        if !rec_doc_params[:tiff].nil?
          require "FileUtils"
          file_move_to = File.expand_path(".")+'/upload/'+@rec_doc.tiff
          FileUtils.move rec_doc_params[:tiff].path,file_move_to
          set_tiff rec_doc_params[:tiff].path
        end
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
      params.require(:rec_doc).permit(:wjnr, :riqi, :year, :year_num, :from, :from_code,:doc_type,:png_num, :tiff)
    end


    # png 文件保存在/approot/public/pic_tmp/
    def set_png
      real_file=File.expand_path(".")+'/upload/'+@rec_doc.tiff
      if @rec_doc.photo.count > 0     #如果数据库中有图片纪录
        @rec_doc.photo.all().each do |pic|     #逐个检查文件是否存在
          p "file  ----->"+pic.file_name
          if File.exist?(File.expand_path(".")+'/pic_tmp/'+pic.file_name)  #不存在则去查找tif文件
            next
          else
            @rec_doc.photo.delete_all()
            set_tiff real_file if File.exist?(real_file)
            return
          end
        end
      elsif File.exist?(real_file)
        set_tiff real_file
      end

      # return false if @rec_doc.tiff.nil?||!File.exist?(File.expand_path(".")+"/upload/"+@rec_doc.tiff+".tif")
      # tiff = ImageList.new(File.expand_path(".")+"/upload/"+@rec_doc.tiff+".tif")
      # @rec_doc.png_num=tiff.length
      # @rec_doc.save
      # set_rec_doc
      # return true if File.exist?(File.expand_path(".")+"/public/png/"+@rec_doc.tiff+"/png-0.png")
      # p "+++++++++++++++++++++"
      # p tiff.length
      # p "+++++++++++++++++++++"
      # @page_num=tiff.length
      # smallcat = cat.minify
      # smallcat.display
      # Dir.mkdir(File.expand_path(".")+"/public/png/"+@rec_doc.tiff)
      # tiff.write(File.expand_path(".")+"/public/png/"+@rec_doc.tiff+"/png.png")
      # return true
    end

    def set_tiff filename
      if !File.exist?(filename)
        Rails.logger.info filename+"不存在！！"
        return
      end
      tiff = ImageList.new(filename)
      pages = tiff.length
      folder = File.expand_path(".")+"/upload/"
      pre_image_name = @rec_doc.doc_type.to_s+"-"+@rec_doc.year.to_s+"-"+@rec_doc.year_num.to_s+"-"
      for i in 0...pages
        png_name = pre_image_name+i.to_s+".png"
        tiff[i].write(folder + png_name)
        Rails.logger.info i
        @rec_doc.photo.create(file_name: png_name,order: i)
      end
    end



end
