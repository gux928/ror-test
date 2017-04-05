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

end
