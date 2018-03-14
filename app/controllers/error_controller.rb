class ErrorController < ApplicationController
	
  def no_match
    respond_to do |format|
      format.html { render_not_found }
      format.js { render json: no_match_json }
      format.json { render json: no_match_json }
    end
    render 'error/404'
  end

  def no_match_json
    {'return_code' => 10002, 'return_info' => '404'}
  end
end