class UsersController < ApplicationController


  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = current_user
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])

    if @user.save
      @user.deliver_verification_instructions!
      redirect_to(root_path, :notice => 'You must now confirm your account. Check your email.') 
    else
      render :action => "new"
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = current_user

      if @user.update_attributes(params[:user])
        redirect_to(@user, :notice => 'User profile successfully updated.')
      else
        render :action => "edit"
      end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = current_user
    @user.destroy
    redirect_to(root_url)
    end
end
