class PasswordResetsController < ApplicationController
  
  before_filter :load_user_using_perishable_token, :only => [:edit, :update]
  
  def new
    render
  end
  
  def create
    @user = User.find_by_email(params[:email])
    if @user
      @user.deliver_password_reset_instructions!
      redirect_to(root_path, :notice => 'Instructions have been emailed to you. Please check your email')
    else
      flash[:notice] = "No user found for that email address."
      render :action => :new
    end
  end
  
  def edit
    render
  end
  
  def update
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.save
      flash[:notice] = "Password successfully updated"
      redirect_to(root_url)
    else
      render :action => :edit
    end
  end
  
  private
  
  def load_user_using_perishable_token
    @user = User.find_using_perishable_token(params[:id])
    unless @user
      flash[:notice] = "We're sorry but we could not find your account."
      redirect_to(root_url)
    end
  end
end
