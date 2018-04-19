class Users::SessionsController < Devise::SessionsController
  layout BlogLayout::DEVISE

  def after_sign_in_path_for(resource_or_scope)
    scope = Devise::Mapping.find_scope!(resource_or_scope)
    router_name = Devise.mappings[scope].router_name
    context = router_name ? send(router_name) : self
    context.send('admin_root_path')
  end
end
