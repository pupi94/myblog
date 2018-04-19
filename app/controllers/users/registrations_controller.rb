class Users::RegistrationsController < Devise::RegistrationsController
  layout BlogLayout::DEVISE

  before_action :configure_sign_up_params, only: [:create]
end
