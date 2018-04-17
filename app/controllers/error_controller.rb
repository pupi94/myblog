class ErrorController < ApplicationController
  def no_match
    render_not_found
  end
end