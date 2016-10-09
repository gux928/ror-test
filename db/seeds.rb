# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

CSV.foreach("test.csv") do |row|
    # p row
    p row[2]
    p row[4]
    p "----------------"
    # i=i+1
    # break if i==100
    RecDoc.create(wjnr:row[4],riqi:row[2],from:row[1],from_code:row[3],year:row[8],year_num:row[7],pic_file_name:row[6])
    end
