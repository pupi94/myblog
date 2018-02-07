class UsersController < ApplicationController
  layout false

  def login ;end

  def do_login
    rtn = User.login(params)
    if Util::success?(rtn) && rtn['user'].present?
      session['user'] = rtn['user']
      redirect_to admin_root_path
    else
      flash[:alert] = rtn['return_info']
      render :login
    end
  end

  def logout
    reset_session
    redirect_to :login
  end
end