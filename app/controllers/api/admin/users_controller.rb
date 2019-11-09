
class Api::Admin::UsersController < AdminController
  def show
    render json: { email: current_user.email }
  end
end