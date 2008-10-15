# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  # protect_from_forgery # :secret => '223e5691ea21da52c543506feb7ec9e4'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  def set_user_cookie(user)
    cookies[:user] = { :value => user.id.to_s, :expires => 1.year.from_now }
  end
  
  def get_user_from_cookie
    if cookies and cookies[:user]
      return User.find(cookies[:user].to_i)
    else
      return nil
    end
  end
  
end
