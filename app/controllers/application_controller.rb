class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user
  
  private
  
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end
  
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end
  
 protected
 
 def authorize
   unless current_user
     session[:blocked_url] =  request.request_uri
     redirect_to(login_path, :notice => "You must be logged in as a verified user first")
   end
 end
 
 def redirect_back_or_default(uri)
   redirect_to(session[:blocked_url] || uri)
   session[:blocked_url] = nil
 end
 
end
