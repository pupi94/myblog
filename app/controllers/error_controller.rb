class ErrorController < ApplicationController
	
  def no_resources
    render 'error/404'
  end
end