require "active_support/all"
class RecDocsController < ApplicationController
  before_action :set_rec_doc, only: [:show, :edit, :update, :destroy,:print]

  # GET /rec_docs
  # GET /rec_docs.json
  def index
    @rec_docs = RecDoc.last(10)
  end

  # GET /rec_docs/1
  # GET /rec_docs/1.json
  def show
  end

  # GET /rec_docs/new
  def new
    @this_year_num = RecDoc.where("year = ?",Time.now.year).maximum("year_num")+1
    @rec_doc = RecDoc.new
  end



  # GET /rec_docs/1/edit
  def edit
  end

  # GET /rec_docs/1/print
  def edit
  end

  # POST /rec_docs
  # POST /rec_docs.json
  def create
    @rec_doc = RecDoc.new(rec_doc_params)

    respond_to do |format|
      if @rec_doc.save
        format.html { redirect_to @rec_doc, notice: 'Rec doc was successfully created.' }
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
    respond_to do |format|
      if @rec_doc.update(rec_doc_params)
        format.html { redirect_to @rec_doc, notice: 'Rec doc was successfully updated.' }
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
      format.html { redirect_to rec_docs_url, notice: 'Rec doc was successfully destroyed.' }
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
      params.require(:rec_doc).permit(:wjnr, :riqi, :year, :year_num, :from, :from_code)
    end
end
