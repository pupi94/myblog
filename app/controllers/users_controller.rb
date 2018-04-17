class UsersController < ApplicationController
  layout false

  def login ;end

  def do_login
    if params[:user_name].blank? || params[:password].blank?
      flash[:alert] = I18n.t('user.error.pwd_or_name_blank')
      render :login
    end

    user = User.login(params[:user_name], params[:password])
    if user.nil?
      flash[:alert] = I18n.t('user.error.password_or_name_wrong')
      render :login
    else
      session['user'] = user
      redirect_to admin_root_path
    end
  end

  def logout
    reset_session
    redirect_to :login
  end
end