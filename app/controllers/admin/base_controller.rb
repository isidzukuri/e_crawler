class Admin::BaseController < ApplicationController
  before_filter :save_path, :check_admin, :authenticate_user!
  load_and_authorize_resource

  layout 'admin/layout'

  private
  def save_path
    session[:previous_url] = admin_path
  end

  def check_admin
    redirect_to(root_path) unless current_user.has_role?(:admin)
  end
end
