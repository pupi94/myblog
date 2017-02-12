class UsersController < ApplicationController
  def login
  	puts "===#{params}"
  end

  def do_login
  	puts "===#{params}"
  end
end