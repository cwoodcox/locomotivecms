class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  def require_ssl
    redirect_options = { :protocol => 'https://', :status => :moved_permanently }
    redirect_options[:host] = Locomotive.config.secure_domain if Locomotive.config.secure_domain.present?
    redirect_to(redirect_options)
  end

  # rescue_from Exception, :with => :render_error
  #
  # def render_error
  #   render :template => "/admin/errors/500", :layout => '/admin/layouts/box', :status => 500
  # end
end
