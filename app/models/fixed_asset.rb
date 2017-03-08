# encoding: utf-8
class FixedAsset < ApplicationRecord
    attr_accessor :quantity

    has_many :photo, as: :imageable

    def self.to_csv(examples)
      Rails.logger.info '「我要开始导出数据了」'
      CSV.generate do |csv|
        # csv << ['A','B','C','D']  #这是文件的headers／
        examples.each do |item|
          csv << [item.number,item.belongs_to,item.main_class,item.sub_class,item.serial_number,item.month_of_purchase,item.position,item.brand,item.model,item.remarks,item.user,item.unit_price,item.photo] #数据内容
        end
      end
    end
end
