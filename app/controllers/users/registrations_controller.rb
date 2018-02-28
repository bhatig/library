class Users::RegistrationsController < Devise::RegistrationsController

  def new
    
    resource = build_resource({})
    resource.addresses.build
    respond_with resource
  end

  
  protected
  
  def after_sign_up_path_for(resource)
    users_path
  end

  def after_update_path_for(resource)
     users_path
  end


end