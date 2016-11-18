# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/



# console.log("222222222")
#
# $ ->
#   $('＃tab-1-next').click ->
#     console.log("222222222")
#
#
# # $(".btn").click ->
# #     console.log("222222222")
#
#
$("input#fixed_asset_number").val("000000005000")
$("#fixed_asset_main_class").val("设备")
$(".main_class_label").eq(4).addClass("active")
$("#fixed_asset_month_of_purchase").val("000000")

console.log($("lable").attr("class"))



next_flag=[0,0,0,0]
next_check = ->
  if next_flag.toString() == [1,1,1,1].toString()
    console.log("checked,ok!!!!")
    $("#tab-1-next").removeAttr("disabled")
  else
    console.log(next_flag)
    console.log("checked,but not ok!")

next_check_2 = ->
  code=$("input#fixed_asset_number").val()
  main_class_code=code.substr(7,2)
  sub_class_code=code.substr(9)
  if main_class_code=="00" || sub_class_code=="000"
     console.log("step 2 checked,bu not ok!!!!")
  else
    console.log("checked,ok!!!!")
    $("#tab-2-next").removeAttr("disabled")


submit_check = ->
  val1=$("input#fixed_asset_brand").val()
  val2=$("input#fixed_asset_model").val()
  val3=$("input#fixed_asset_unit_price").val()
  console.log(val1+"  "+val2+"  "+val3)
  if val1=="" and val1=="" || val3==""
    console.log("submit checked,bu not ok!!!!")
  else
    console.log("submit checked,ok!!!!")
    $("#submit-btn").removeAttr("disabled")







$(".btn#tab-1-next").click ->
  $('#tab-1').fadeOut(0)
  $('#tab-2').fadeIn(600)
  console.log("show tab_2")

# $('#tab-1')
#   .css
#     'font-size' : 20px
$(".btn#tab-2-pre").click ->
  $('#tab-2').fadeOut(0)
  $('#tab-1').fadeIn(600)
  console.log("show tab_1")

$(".btn#tab-2-next").click ->
  $('#tab-2').fadeOut(0)
  $('#tab-form').fadeIn(600)
  console.log("show tab-form")

$(".btn#tab-form-pre").click ->
  $('#tab-form').fadeOut(0)
  $('#tab-2').fadeIn(600)
  console.log("show tab-2")



$(".belong-label").click ->
  console.log($(this).attr("class")+" index("+$(this).index()+") pressed")
  code=$("input#fixed_asset_number").val()
  new_code=$(this).children().val()+code.substr(1)
  $("input#fixed_asset_number").val(new_code)
  $("#fixed_asset_belongs_to").val($(this).attr("key"))
  next_flag[0]=1
  next_check()


$(".yy-label").click ->
  console.log($(this).attr("class")+" index("+$(this).index()+") pressed")
  code=$("input#fixed_asset_number").val()
  new_code=code.substr(0,1)+$(this).children().val()+code.substr(5)
  $("input#fixed_asset_number").val(new_code)
  mop=$("input#fixed_asset_month_of_purchase").val()
  new_mop=$(this).children().val()+mop.substr(4)
  $("input#fixed_asset_month_of_purchase").val(new_mop)
  next_flag[1]=1
  next_check()



$(".mm-label").click ->
  console.log($(this).attr("class")+" index("+$(this).index()+") pressed")
  code=$("input#fixed_asset_number").val()
  mm=$(this).children().val()/1+100+""
  new_code=code.substr(0,5)+mm.substr(1)+code.substr(7)
  $("input#fixed_asset_number").val(new_code)
  mop=$("input#fixed_asset_month_of_purchase").val()
  new_mop=mop.substr(0,4)+$(this).children().val()
  $("input#fixed_asset_month_of_purchase").val(new_mop)
  next_flag[2]=1
  next_check()


$(".quantity-label").click ->
  $("#tab-1-next").attr("disabled","disabled")
  setTimeout ->
    console.log($(this).attr("class")+" index("+$(this).index()+") pressed")
    console.log($(".quantity-label.active").index()+" actived")
    q_value=0
    $(".quantity-label.active").each ->
      console.log($(this).children().val()+"value=")
      q_value=q_value+$(this).children().val()/1
      $("input#fixed_asset_quantity").val(q_value)
      if q_value>0
        next_flag[3]=1
      else
        next_flag[3]=0
      next_check()
  ,0




#第二页

$(".main_class_label").click ->
  $(".sub_class_label").removeClass("active")
  $("#tab-2-next").attr("disabled","disabled")
  console.log($(this).children().attr("name")+" label press")
  index=$(this).attr('tab-index')*1-1
  console.log(index)
  $(".sub_class_tab").hide()
  $(".sub_class_tab").eq(index).show()
  code=$("input#fixed_asset_number").val()
  new_code=code.substr(0,7)+$(this).children().val()+"000"
  $("input#fixed_asset_number").val(new_code)
  console.log($(this).attr('key'))
  $("#fixed_asset_main_class").val($(this).attr('key'))
  next_check_2()


$(".sub_class_label").click ->
  $(".sub_class_label").removeClass("active")
  $(this).addClass("active")
  console.log($(this).children().attr("name")+" label press")
  index=$(this).attr('tab-index')*1-1
  console.log(index)
  code=$("input#fixed_asset_number").val()
  new_code=code.substr(0,9)+$(this).children().val()
  $("input#fixed_asset_number").val(new_code)
  $("#fixed_asset_sub_class").val($(this).attr('key'))
  next_check_2()



#表单页面
$("input#fixed_asset_brand,input#fixed_asset_model,input#fixed_asset_unit_price").on "click", ->
  $("#submit-btn").attr("disabled","disabled")
  console.log("input clicked")
  submit_check()
$("input#fixed_asset_brand,input#fixed_asset_model,input#fixed_asset_unit_price").on "keyup", ->
  $("#submit-btn").attr("disabled","disabled")
  console.log("input keypress")
  submit_check()


submit_check()
