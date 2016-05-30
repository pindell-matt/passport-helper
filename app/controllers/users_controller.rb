class UsersController < ApplicationController

  def new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = user.id
      flash[:success] = "Thanks for signing up!"
      redirect_to complete_registration_path
    else
      flash.now[:warning] = @user.errors.full_messages.join("<br />").html_safe
      render "sessions/new"
    end
  end

  def complete
    @user = current_user
  end

  def update
    current_user.finish_registration(user_params)
    redirect_to user_dashboard_path
  end

  private

    def user_params
      params.require(:user).permit(:provider, :email, :password, :name, :image_url)
    end

end
