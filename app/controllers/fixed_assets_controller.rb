# encoding: utf-8
class FixedAssetsController < ApplicationController
  before_action :login_check
  before_action :set_fixed_asset, only: [:show, :edit, :update, :destroy,:upload,:save_pic]

  # GET /fixed_assets
  # GET /fixed_assets.json
  require 'yaml'
  def index
    # @fixed_assets = FixedAsset.all
    # my_code=YAML.load(File.open(File.expand_path(".")+"/code.yml"))
    # p my_code
    # my_code["belong_code"].each_with_index do |k,v,i| puts "#{k} #{v} #{i}" end
    # File.open( File.expand_path(".")+"/code.yml" ) do |yf|
    #   YAML.each_node( yf ) do |ydoc|
    #     p ydoc
    #     p yf
    # ## ydoc contains a tree of nodes
    # ## from the YAML document
    #   end
    # end
    @q=FixedAsset.ransack(params[:q])
    if params[:q].nil?
      @fixed_assets = FixedAsset.paginate(page: params[:page], per_page: 15).order(created_at: :desc)
    else
      @fixed_assets=@q.result.paginate(page: params[:page], per_page: 15).order(created_at: :desc)
    end
  end

  # GET /fixed_assets/1
  # GET /fixed_assets/1.json
  def show
  end

  def upload
  end

  def save_pic
    p params[:file].tempfile.path
    my_path=File.expand_path(".")+"/public/fixed_assets_pic/"+@fixed_asset.number
    if @fixed_asset.photo.nil?
      @fixed_asset.photo=1
      Dir.mkdir(my_path) if File.exist?(my_path)
    else
      @fixed_asset.photo=0 if @fixed_asset.photo.to_i>1000
      @fixed_asset.photo=@fixed_asset.photo.to_i+1
    end
    @fixed_asset.save
    uploaded_io=params[:file]
    real_file=my_path+"/"+@fixed_asset.photo.to_s+File.extname(params[:file].original_filename)
    File.open(real_file,'wb') do |file|
      file.write(uploaded_io.read)
    end
    my_dir=Dir.open(my_path)
    p Dir.entries(my_path)
    my_dir.each do |filename|
      p filename
    end
  end

  # GET /fixed_assets/new
  def new
    @fixed_asset = FixedAsset.new
    @fixed_asset.number="005000000000000"
    @fixed_asset.month_of_purchase="000000"
    @fixed_asset.main_class="设备"
    @my_code=YAML.load(File.open(File.expand_path(".")+"/code.yml"))
  end

  # GET /fixed_assets/1/edit
  def edit
  end

  # POST /fixed_assets
  # POST /fixed_assets.json
  def create
    # p @fixed_asset
    p fixed_asset_params[:quantity]
    # redirect_to root_path
    for i in 1..fixed_asset_params[:quantity].to_i
      @fixed_asset = FixedAsset.new(fixed_asset_params)
      @fixed_asset.serial_number=(1000+i).to_s[1,3]
      @fixed_asset.number=@fixed_asset.number[0,12]+@fixed_asset.serial_number
      if @fixed_asset.save
          # format.html { redirect_to @fixed_asset, notice: 'Fixed asset was successfully created.' }
          # format.json { render :show, status: :created, location: @fixed_asset }
      else
          format.html { render :new }
          format.json { render json: @fixed_asset.errors, status: :unprocessable_entity }
      end
    end
    redirect_to fixed_assets_path
  end

  # PATCH/PUT /fixed_assets/1
  # PATCH/PUT /fixed_assets/1.json
  def update
    p fixed_asset_params
    fixed_asset_params['month_of_purchase']=fixed_asset_params["number"][6,6]
    p " "
    p " "
    p " "
    kkk=fixed_asset_params
    p kkk
    fixed_asset_params[:month_of_purchase]=fixed_asset_params["number"][6,6]
    kkk[:month_of_purchase]=fixed_asset_params["number"][6,6]
    p " "
    p kkk[:month_of_purchase]
    p fixed_asset_params[:month_of_purchase]
    p " "
    p " "
    p " "
    #好奇葩的问题，为什么params不能被修改？
    respond_to do |format|
      if @fixed_asset.update(kkk)
        format.html { redirect_to @fixed_asset, notice: '资产信息修改成功！' }
        format.json { render :show, status: :ok, location: @fixed_asset }
      else
        format.html { render :edit }
        format.json { render json: @fixed_asset.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fixed_assets/1
  # DELETE /fixed_assets/1.json
  def destroy
    num=@fixed_asset.number
    @fixed_asset.destroy
    respond_to do |format|
      format.html { redirect_to fixed_assets_url, notice: num+'   删除成功' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fixed_asset
      @fixed_asset = FixedAsset.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fixed_asset_params
      params.require(:fixed_asset).permit(:serial, :number,:belongs_to,:main_class,:sub_class,:month_of_purchase,:brand,:model,:unit_price,:remarks,:quantity,:user)
    end
end
