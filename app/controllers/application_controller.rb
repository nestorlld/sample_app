class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery 
  include SessionsHelper
  
  #force Signout to prevent CSRF attacks
  def handle_unverified_requests
    sign_out
    super
  end
  
  
  
  #added to deal with something related to strong parameters
  before_filter do
  resource = controller_name.singularize.to_sym
  method = "#{resource}_params"
  params[resource] &&= send(method) if respond_to?(method, true)
  end
end
