class UsersController < ApplicationController
  layout :resolve_layout
  before_filter :login_required, :except => [:login, :do_login]

  def login

    puts "===#{params}========#{ErrorCode::SUCCESS}"
  end

  def do_login
    puts "===#{params}"
    redirect_to users_login_path, :flash=>{:alert=>"user not exist!"}
  end


private
  def resolve_layout
    case action_name
    when 'login', 'do_login'
      'user'
    else
      'application'
    end
  end
end