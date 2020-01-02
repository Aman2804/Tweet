class ApplicationController < ActionController::Base
  protect_from_forgery unless: -> { request.format.json? }
  before_action :authenticate_api_v1_user!, :do_not_set_cookie, if: -> { request.format.json? }
  private
  def after_sign_in_path_for(resource)
    rails_admin_url
  end

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_url
  end

  # Do not generate a session or session ID cookie
  # See https://github.com/rack/rack/blob/master/lib/rack/session/abstract/id.rb#L171
  def do_not_set_cookie
    request.session_options[:skip] = true
  end
end
