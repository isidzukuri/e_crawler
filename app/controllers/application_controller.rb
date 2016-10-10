class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  load_and_authorize_resource

  def initialize
    post_initialize
    super
  end

  private

  def post_initialize
  end
end
