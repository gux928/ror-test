# encoding: utf-8
class FixedAsset < ApplicationRecord
    attr_accessor :quantity
    validates :state, inclusion: { in: %w(使用 报废 停用未报废),message: "资产状态错误!"}
    # validates :state, inclusion: { in: %w(small medium large),message: "%{value} is not a valid size" }

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
