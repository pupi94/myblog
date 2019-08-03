# frozen_string_literal: true

class ErrorController < ApplicationController
  def no_match
    record_not_found
  end
end
