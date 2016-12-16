class FixedAsset < ApplicationRecord
    attr_accessor :quantity
    def self.to_csv(examples)
      Rails.logger.info '「我要开始导出数据了」'
      CSV.generate do |csv|
        # csv << ['A','B','C','D']  #这是文件的headers／
        examples.each do |item|
          # RecDoc.create(wjnr:row[3],riqi:row[4],from:row[2],from_code:row[8],year:row[9],year_num:row[1],tiff:tiff1,doc_type:1)
          csv << [item.number,item.belongs_to,item.main_class,item.sub_class,item.serial_number,item.month_of_purchase,item.position,item.brand,item.brand,item.model,item.remarks,item.user,item.unit_price,item.photo] #数据内容
        end
      end
    end
end
