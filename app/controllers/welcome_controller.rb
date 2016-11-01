class WelcomeController < ApplicationController
  def index
    @q=RecDoc.ransack(params[:q])
    @rec_docs=@q.result(distinct:true)
    p @rec_docs
  end
end
