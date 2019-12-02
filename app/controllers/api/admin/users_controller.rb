# frozen_string_literal: true

class Api::Admin::UsersController < Api::AdminController
  def show
    render json: { email: current_user.email }
  end
end
