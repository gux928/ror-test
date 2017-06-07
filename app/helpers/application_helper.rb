module ApplicationHelper
  def pic_list(dir,extname,num)
    return if !File.exist?(File.expand_path(".")+"/public/"+dir)||num.to_i<1
    s=""
    for i in 1..num.to_i
      s=s+"
      <div class='col-xs-2'>
        <a href=/"+dir+"/"+i.to_s+"."+extname+" data-lightbox="+dir+" data-title='' class='thumbnail'>
            <img src=/"+dir+"/"+i.to_s+"."+extname+" alt="+dir+">
        </a>
      </div>"
    end
    return s
  end

  def bootstrap_class_for flash_type
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }[flash_type.to_sym] || flash_type.to_s
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      # p msg_type,message,bootstrap_class_for(msg_type.to_sym),{ success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }[:notice]
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} fade in") do
              concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
              concat message
            end)
    end
    nil
  end

end
