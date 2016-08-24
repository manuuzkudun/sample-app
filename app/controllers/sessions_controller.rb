class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    # Find user in the db specifying email
    user = User.find_by(email: params[:session][:email].downcase)
    # If the user exists and is authenticated
    if user && user.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
      log_in user
      remember user
      redirect_to users_url(user)
    else
      flash.now[:danger] = 'Invalid email/password combination' # Not quite right!
      render 'new'
    end
  end
  
  def destroy
    log_out
    redirect_to root_url
  end
  
end