class UsersController < ApplicationController
  before_filter :login_required, :except => [:login, :do_login]

  def login
    respond_to do |format|
        format.html {
          render "login",
          layout: false
        }
    end
  end

  def do_login
    rtn = User.login(params)
    if Util::success?(rtn) && rtn['user'].present?
        session["user"] = rtn['user']
        redirect_to content_manage_index_path
    else
      respond_to do |format|
        format.html {
          render "login",
          layout: false,
          locals: {
            :flash => {:alert=> rtn['return_info']}
         }
        }
      end
    end
  end

  def logout
    reset_session
    respond_to do |format|
      format.html { 
        render "login",
        layout: false
      }
    end
  end
end