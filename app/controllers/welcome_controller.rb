class WelcomeController < ApplicationController
  before_action :login_check

  def index
    @q=RecDoc.ransack(params[:q])
    # @rec_docs=@q.result(distinct:true)
    # p @rec_docs
  end

  def upload

  end

  def download_doc
    @rec_docs  = RecDoc.all
    respond_to do |format|
      format.csv { send_data RecDoc.to_csv(@rec_docs), filename:"Doc.csv"}
    end
  end

  def download_fa
    @fas  = FixedAsset.all
    respond_to do |format|
      format.csv { send_data FixedAsset.to_csv(@fas), filename:"FixedAsset.csv"}
    end
  end

  def download_db
    dbfile = Time.now.to_i.to_s + '.dbb'
    filename = Rails.root.join('upload',dbfile)
    p filename
    system "pg_dump -Fc -f #{filename}"
    send_file filename
  end
  

  def import_csv
    require 'yaml'
    @my_code=YAML.load(File.open(File.expand_path(".")+"/code.yml"))
    p @my_code['belong_code'].key('1')
    path2=params[:csv_file].tempfile.path
    require 'csv'
    i=0
    k=0
    p params[:file_type]

    if params[:file_type]=="doc_file"
      RecDoc.delete_all()
      CSV.foreach(path2) do |row|
        i=i+1
        if row[10]=="xf"
          yy = row[9]||"2000"
          nn = row[1]||"0"
          tiff1="1"+"-"+yy+"-"+nn
          RecDoc.create(wjnr:row[3],riqi:row[4],from:row[2],from_code:row[8],year:row[9],year_num:row[1],tiff: tiff1,doc_type:1)
        else
          yy = row[8]||"2000"
          nn = row[7]||"0"
          tiff1="0"+"-"+yy+"-"+nn
          RecDoc.create(wjnr:row[4],riqi:row[2],from:row[1],from_code:row[3],year:row[8],year_num:row[7],tiff: tiff1,doc_type:0)
        end
        p i
        p row
      end
    else
      CSV.foreach(path2) do |row|
        k=k+1
        p k
        p row[6]
        a1=@my_code['belong_code'].key(row[6][0,1])
        a2=@my_code['main_class_code'].key(row[6][1,2])
        a3=@my_code['equipment_code'].key(row[6][3,3])
        num=row[5].to_i
        for i in 1..num
          if i==1
            a4=row[6]
          else
            a4=row[6][0,12]+(1000+i).to_s[1,3]
          end
          p i
          p a4
          FixedAsset.create(number:a4,belongs_to:a1,main_class: a2,sub_class:a3,month_of_purchase:row[6][6,6],brand:row[0],model:row[1],unit_price:row[3],remarks:row[7]+row[8])
        end
        break if k > 10
      end
      redirect_to fixed_assets_path
    end
  end


  def import_csv_new
    require 'yaml'
    @my_code=YAML.load(File.open(File.expand_path(".")+"/code.yml"))
    p @my_code['belong_code'].key('1')
    path2=params[:csv_file].tempfile.path
    require 'csv'
    i=0
    p params[:file_type]

    if params[:file_type]=="doc_file"
      RecDoc.delete_all()
      CSV.foreach(path2) do |row|
        i=i+1
        p i
        p row
        RecDoc.create(doc_type:row[0],riqi:row[1],year:row[2],year_num:row[3],wjnr:row[4],from:row[5],from_code:row[6],tiff: row[7])
      end
      redirect_to rec_docs_path
    else
      FixedAsset.delete_all()
      CSV.foreach(path2) do |row|
        i=i+1
        p i
        p row[6]
        # a1=@my_code['belong_code'].key(row[0][0,1])
        # a2=@my_code['main_class_code'].key(row[0][1,2])
        # a3=@my_code['equipment_code'].key(row[0][3,3])
        FixedAsset.create(number:row[0],belongs_to:row[1],main_class: row[2],sub_class:row[3],
          month_of_purchase:row[5],brand:row[7],model:row[8],unit_price:row[11],remarks:row[9])
        break if i > 10
      end
    end
  end

  def import_db
    p params[:csv_file].tempfile.path
    system "pg_restore  -U  postgres -d postgres #{params[:csv_file].tempfile.path} -c"
    redirect_to root_path    
  end

  def test_func
    p "begin!!!"*30
    p Rails.root
    p File.path('./upload/db.dbb')
    dbfile = Time.now.to_i.to_s + '.dbb'
    filename = Rails.root.join('upload',dbfile)
    p filename
    system "pg_dump  -U  postgres  -Fc -f #{filename} postgres"
    # system "pg_restore  -U  postgres -d postgres dbb -c"
    # send_file filename
    p "ok!!!"*30
    render plain: "okokok"
  end
  


end
