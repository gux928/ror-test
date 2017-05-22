# encoding: utf-8
class RecDoc < ApplicationRecord

  attr_accessor :tiff
  validates  :from, presence:  {message: "文件来源没有输入！"}
  validates_presence_of :wjnr, message:"文件内容没有输入！"
  # validates :year_num, uniqueness: { scope: [:year,:doc_type]
  #   message: "编号不可重复！"}
  validates_uniqueness_of :year_num, scope: [:year, :doc_type]

  has_many :photo, as: :imageable

  require 'csv'

  def self.to_csv(examples)
    Rails.logger.info '「我要开始导出数据了」'
    CSV.generate do |csv|
      # csv << ['A','B','C','D']  #这是文件的headers／
      examples.each do |item|
        # RecDoc.create(wjnr:row[3],riqi:row[4],from:row[2],from_code:row[8],year:row[9],year_num:row[1],tiff:tiff1,doc_type:1)
        csv << [item.doc_type,item.riqi,item.year,item.year_num,item.wjnr,item.from,item.from_code,item.tiff] #数据内容
      end
    end
  end

  def tiff
    doc_type.to_s+"-"+year.to_s+"-"+year_num.to_s+".tif"
  end
end
