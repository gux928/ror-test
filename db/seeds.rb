# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

CSV.foreach("mydoc.csv") do |row|
    # p row
    p row[0]
    # p row[4]
    p "----------------"
    # i=i+1
    # break if i==100
    tiff=nil
    if row[10]=="xf"
      tiff="1"+"-"+row[9]+"-"+row[1] unless row[9].nil?||row[1].nil?||row[6].nil?
      RecDoc.create(wjnr:row[3],riqi:row[4],from:row[2],from_code:row[8],year:row[9],year_num:row[1],tiff:tiff,doc_type:1)
    else
      tiff="0"+"-"+row[8]+"-"+row[7] unless row[8].nil?||row[7].nil?||row[6].nil?
      RecDoc.create(wjnr:row[4],riqi:row[2],from:row[1],from_code:row[3],year:row[8],year_num:row[7],tiff:tiff,doc_type:0)
    end
  end
