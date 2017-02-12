class AdminController < ApplicationController
  layout "admin"

  def index
  	puts "===#{params}"
  end

end

