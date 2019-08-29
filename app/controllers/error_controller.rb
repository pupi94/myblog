# frozen_string_literal: true

class ErrorController < ApplicationController
  def no_match
    respond_to do |format|
      format.html { render "error/404" }
      format.js { render_not_found }
      format.json { render_not_found }
    end
  end
end
