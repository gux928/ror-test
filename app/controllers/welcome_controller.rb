class WelcomeController < ApplicationController
  before_action :login_check
  
  def index
    @q=RecDoc.ransack(params[:q])
    # @rec_docs=@q.result(distinct:true)
    # p @rec_docs
  end
end
