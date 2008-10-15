class UsersController < ApplicationController
  
  def index
    @users = User.find(:all)
  end

  def show
    @user = User.find_by_name(CGI::unescape(params[:name]))
    @page_title = " - #{CGI::unescape(params[:name])}"
  end

end
