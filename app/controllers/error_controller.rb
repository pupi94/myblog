class ErrorController < ApplicationController
  def no_match
    record_not_found
  end
end