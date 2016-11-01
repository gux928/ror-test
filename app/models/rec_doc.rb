class RecDoc < ApplicationRecord
  validates  :from, presence:  {message: "文件来源没有输入！"}
  validates_presence_of :wjnr, message:"文件内容没有输入！"
  # validates :year_num, uniqueness: { scope: [:year,:doc_type]
  #   message: "编号不可重复！"}
  validates_uniqueness_of :year_num, scope: [:year, :doc_type]
end
