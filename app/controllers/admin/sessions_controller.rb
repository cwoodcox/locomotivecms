module Admin
  class SessionsController < Devise::SessionsController

    include Locomotive::Routing::SiteDispatcher

    layout '/admin/layouts/box'

    before_filter :require_site
    before_filter :require_ssl, :if => lambda { Locomotive.config.enable_admin_ssl }, :unless => lambda { request.ssl? }

    helper 'admin/base', 'admin/box'

    protected

    def after_sign_in_path_for(resource)
      admin_pages_url
    end

    def after_sign_out_path_for(resource)
      request.protocol + request.host_with_port
    end

  end
end
